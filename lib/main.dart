import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:fristonevs/UI/homeScreen.dart';
import 'package:fristonevs/data_model/therapyProgram.dart';
import 'package:fristonevs/fitenessService.dart';
import 'package:fristonevs/repo/repoImplement.dart';
import 'package:fristonevs/stateManagment/stateManagment.dart';
import 'dart:math' as math;

import 'package:provider/provider.dart';

void main() {
  runApp(const FutearApp());
}

// App Constants
class AppConstants {
  static const String appName = 'VOLER';
  static const String arabicFont = 'Tajawal';
  static const Color primaryColor = Color(0xFF00D9F5);
  static const Color secondaryColor = Color(0xFF7626F5);
  static const Color accentColor = Color(0xFF34C759);
  static const Color backgroundColor = Color(0xFF0A0E21);
  static const Color surfaceColor = Color(0xFF1D1F33);
  
  // Egyptian cultural elements
  static const List<String> egyptianCities = [
    'Cairo', 'Alexandria', 'Giza', 'Luxor', 'Aswan', 'Sharm El-Sheikh'
  ];
  
  static const Map<String, String> arabicTranslations = {
    'welcome': 'مرحبا بك',
    'therapy': 'جلسات العلاج',
    'fitness': 'اللياقة البدنية',
    'nutrition': 'التغذية',
    'progress': 'التقدم',
    'profile': 'الملف الشخصي',
    'settings': 'الإعدادات',
  };
}

// Abstract Service Classes (following Dependency Inversion Principle)
abstract class ITherapyService {
  Future<List<TherapyProgram>> getTherapyPrograms();
}

abstract class IFitnessService {
  Future<List<FitnessProgram>> getFitnessPrograms();
}

abstract class IUserRepository {
  Future<UserProfile> getUserProfile();
  Future<void> updateUserProfile(UserProfile profile);
}

// Concrete Service Implementations
class TherapyService implements ITherapyService {
  @override
  Future<List<TherapyProgram>> getTherapyPrograms() async {
    // Simulate API call
    await Future.delayed(const Duration(seconds: 1));
    
    return [
      TherapyProgram(
        'Physical Therapy',
        '12 exercises designed for back pain',
        Icons.accessible_forward,
        AppConstants.secondaryColor,
        75,
      ),
      TherapyProgram(
        'Mental Wellness',
        '7 sessions for stress relief',
        Icons.psychology,
        AppConstants.primaryColor,
        60,
      ),
      TherapyProgram(
        'Rehabilitation',
        'Custom program for joint recovery',
        Icons.healing,
        Colors.orange,
        90,
      ),
      TherapyProgram(
        'Traditional Egyptian Therapy',
        'Inspired by ancient techniques',
        Icons.spa,
        Colors.green,
        45,
      ),
    ];
  }
}


// Main App
class FutearApp extends StatelessWidget {
  const FutearApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize services with dependency injection
    final userRepository = UserRepository();
    final appState = AppState(userRepository);
    
    return ChangeNotifierProvider(
      create: (context) => appState,
      child: MaterialApp(
        title: AppConstants.appName,
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: AppConstants.backgroundColor,
          colorScheme: const ColorScheme.dark(
            primary: AppConstants.primaryColor,
            secondary: AppConstants.secondaryColor,
            surface: AppConstants.surfaceColor,
            background: AppConstants.backgroundColor,
          ),
          textTheme: const TextTheme(
            displayLarge: TextStyle(
              fontSize: 32.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontFamily: AppConstants.arabicFont,
            ),
            displayMedium: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.w600,
              color: Colors.white,
              fontFamily: AppConstants.arabicFont,
            ),
            bodyLarge: TextStyle(
              fontSize: 18.0,
              color: Colors.white70,
              fontFamily: AppConstants.arabicFont,
            ),
            bodyMedium: TextStyle(
              fontSize: 16.0,
              color: Colors.white70,
              fontFamily: AppConstants.arabicFont,
            ),
          ),
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
  