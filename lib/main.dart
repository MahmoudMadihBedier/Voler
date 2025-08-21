import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:fristonevs/UI/homeScreen.dart';
import 'package:fristonevs/data_model/therapyProgram.dart';
import 'package:fristonevs/fitenessService.dart';
import 'package:fristonevs/repo/repoImplement.dart';
import 'package:fristonevs/stateManagment/abstractServices.dart';
import 'package:fristonevs/stateManagment/stateManagment.dart';
import 'package:fristonevs/theme/theme.dart';
import 'dart:math' as math;

import 'package:provider/provider.dart';

void main() {
  runApp(const FutearApp());
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
  