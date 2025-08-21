// Home Screen
import 'package:flutter/material.dart';
import 'package:fristonevs/data_model/therapyProgram.dart';
import 'package:fristonevs/fitenessService.dart';
import 'package:fristonevs/stateManagment/stateManagment.dart';
import 'package:fristonevs/theme/concrete.dart';
import 'package:fristonevs/theme/theme.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);

    _controller.forward();

    // Load user profile when the app starts
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final appState = Provider.of<AppState>(context, listen: false);
      appState.loadUserProfile();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // App Bar
              _buildAppBar(context),
              const SizedBox(height: 24),

              // Main Content with animation
              Expanded(
                child: PageView(
                  onPageChanged: (index) {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                  children: [
                    _buildDashboard(context),
                    _buildTherapySection(),
                    _buildFitnessSection(),
                    _buildNutritionSection(),
                  ],
                ),
              ),

              // Bottom Navigation Indicator
              _buildPageIndicator(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    final user = appState.userProfile;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ScaleTransition(
          scale: _animation,
          child: const CircleAvatar(
            backgroundColor: AppConstants.secondaryColor,
            child: Text(
              "F",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
        FadeTransition(
          opacity: _animation,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "Futear",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                ),
              ),
              if (user != null)
                Text(
                  "${AppConstants.arabicTranslations['welcome']}, ${user.name}",
                  style: const TextStyle(fontSize: 12, color: Colors.white70),
                ),
            ],
          ),
        ),
        ScaleTransition(
          scale: _animation,
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white.withOpacity(0.2)),
            ),
            child: Icon(
              Icons.notifications_none,
              color: Colors.white.withOpacity(0.8),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDashboard(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    final user = appState.userProfile;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FadeTransition(
          opacity: _animation,
          child: Text(
            user?.city ?? 'Egypt',
            style: const TextStyle(fontSize: 18, color: Colors.white70),
          ),
        ),
        const SizedBox(height: 4),
        FadeTransition(
          opacity: _animation,
          child: Text(
            user != null
                ? '${user.age} years, ${user.fitnessLevel}'
                : 'Loading...',
            style: const TextStyle(fontSize: 16, color: Colors.white70),
          ),
        ),
        const SizedBox(height: 32),

        // Stats Cards
        SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, 0.5),
            end: Offset.zero,
          ).animate(_animation),
          child: _buildGlassCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Today's Activity",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildStatItem("7,892", "Steps", Icons.directions_walk),
                    _buildStatItem(
                      "32",
                      "Therapy\nMinutes",
                      Icons.medical_services,
                    ),
                    _buildStatItem(
                      "45",
                      "Workout\nMinutes",
                      Icons.fitness_center,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 24),

        // Quick Actions
        SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, 0.5),
            end: Offset.zero,
          ).animate(_animation),
          child: Text(
            "${AppConstants.arabicTranslations['therapy']} & ${AppConstants.arabicTranslations['fitness']}",
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
        ),
        const SizedBox(height: 16),

        GridView.count(
          shrinkWrap: true,
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          children: [
            _buildActionButton(
              AppConstants.arabicTranslations['therapy']!,
              Icons.medical_services,
              AppConstants.secondaryColor,
              onTap: () => setState(() => _currentIndex = 1),
            ),
            _buildActionButton(
              AppConstants.arabicTranslations['fitness']!,
              Icons.fitness_center,
              AppConstants.primaryColor,
              onTap: () => setState(() => _currentIndex = 2),
            ),
            _buildActionButton(
              AppConstants.arabicTranslations['nutrition']!,
              Icons.restaurant,
              const Color(0xFFFF2D55),
              onTap: () => setState(() => _currentIndex = 3),
            ),
            _buildActionButton(
              AppConstants.arabicTranslations['progress']!,
              Icons.analytics,
              const Color(0xFF34C759),
              onTap: () {},
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTherapySection() {
    final therapyService = TherapyService();

    return FutureBuilder<List<TherapyProgram>>(
      future: therapyService.getTherapyPrograms(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        final programs = snapshot.data!;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FadeTransition(
              opacity: _animation,
              child: Text(
                AppConstants.arabicTranslations['therapy']!,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 16),

            Expanded(
              child: ListView(
                children: programs
                    .map((program) => _buildProgramCard(program))
                    .toList(),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildFitnessSection() {
    final fitnessService = FitnessService();

    return FutureBuilder<List<FitnessProgram>>(
      future: fitnessService.getFitnessPrograms(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        final programs = snapshot.data!;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FadeTransition(
              opacity: _animation,
              child: Text(
                AppConstants.arabicTranslations['fitness']!,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 16),

            Expanded(
              child: ListView(
                children: programs
                    .map((program) => _buildWorkoutCard(program))
                    .toList(),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildNutritionSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FadeTransition(
          opacity: _animation,
          child: Text(
            AppConstants.arabicTranslations['nutrition']!,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 16),

        Expanded(
          child: ListView(
            children: [
              _buildNutritionCard(
                'Mediterranean Diet Plan',
                'Traditional Egyptian foods with modern nutrition science',
                Icons.restaurant_menu,
                Colors.green,
              ),
              _buildNutritionCard(
                'Ramadan Nutrition Guide',
                'Healthy eating during fasting hours',
                Icons.nightlight_round,
                Colors.blue,
              ),
              _buildNutritionCard(
                'Hydration Strategy',
                'Essential for Egypt\'s climate',
                Icons.local_drink,
                Colors.lightBlue,
              ),
              _buildNutritionCard(
                'Local Superfoods',
                'Discover Egyptian nutritional treasures',
                Icons.spa,
                Colors.orange,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildGlassCard({required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white.withOpacity(0.07),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      child: child,
    );
  }

  Widget _buildStatItem(String value, String label, IconData icon) {
    return Column(
      children: [
        Icon(icon, color: AppConstants.primaryColor, size: 28),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 12, color: Colors.white.withOpacity(0.7)),
        ),
      ],
    );
  }

  Widget _buildActionButton(
    String title,
    IconData icon,
    Color color, {
    VoidCallback? onTap,
  }) {
    return ScaleTransition(
      scale: _animation,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [color.withOpacity(0.7), color.withOpacity(0.3)],
          ),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.2),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(16),
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(icon, color: Colors.white, size: 32),
                  const SizedBox(height: 8),
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProgramCard(TherapyProgram program) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(0.5, 0),
        end: Offset.zero,
      ).animate(_animation),
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              program.color.withOpacity(0.3),
              program.color.withOpacity(0.1),
            ],
          ),
          border: Border.all(color: Colors.white.withOpacity(0.1)),
        ),
        child: ListTile(
          leading: Icon(program.icon, color: program.color, size: 32),
          title: Text(
            program.title,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          subtitle: Text(program.description),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '${program.duration} min',
                style: TextStyle(
                  color: program.color,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          onTap: () {},
        ),
      ),
    );
  }

  Widget _buildWorkoutCard(FitnessProgram program) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(0.5, 0),
        end: Offset.zero,
      ).animate(_animation),
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        height: 120,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          image: DecorationImage(
            image: NetworkImage(
              "https://picsum.photos/400/200?random=${program.title.hashCode}",
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.transparent, Colors.black.withOpacity(0.7)],
            ),
          ),
          child: ListTile(
            leading: Icon(program.icon, color: program.color, size: 32),
            title: Text(
              program.title,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            subtitle: Text(program.description),
            trailing: IconButton(
              icon: const Icon(
                Icons.play_circle_fill,
                color: Colors.white,
                size: 36,
              ),
              onPressed: () {},
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNutritionCard(
    String title,
    String subtitle,
    IconData icon,
    Color color,
  ) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(0.5, 0),
        end: Offset.zero,
      ).animate(_animation),
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [color.withOpacity(0.3), color.withOpacity(0.1)],
          ),
          border: Border.all(color: Colors.white.withOpacity(0.1)),
        ),
        child: ListTile(
          leading: Icon(icon, color: color, size: 32),
          title: Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          subtitle: Text(subtitle),
          trailing: Icon(
            Icons.arrow_forward_ios,
            color: Colors.white.withOpacity(0.5),
          ),
          onTap: () {},
        ),
      ),
    );
  }

  Widget _buildPageIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(4, (index) {
        return Container(
          width: 8,
          height: 8,
          margin: const EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _currentIndex == index
                ? AppConstants.primaryColor
                : Colors.white.withOpacity(0.3),
          ),
        );
      }),
    );
  }

  Widget _buildBottomNavigationBar() {
    return Container(
      decoration: BoxDecoration(
        color: AppConstants.surfaceColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        backgroundColor: Colors.transparent,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppConstants.primaryColor,
        unselectedItemColor: Colors.white70,
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.home),
            label: AppConstants.arabicTranslations['welcome']!,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.medical_services),
            label: AppConstants.arabicTranslations['therapy']!,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.fitness_center),
            label: AppConstants.arabicTranslations['fitness']!,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.restaurant),
            label: AppConstants.arabicTranslations['nutrition']!,
          ),
        ],
      ),
    );
  }
}
