

// Concrete Service Implementations
import 'package:flutter/material.dart';
import 'package:fristonevs/data_model/therapyProgram.dart';
import 'package:fristonevs/stateManagment/abstractServices.dart';
import 'package:fristonevs/theme/theme.dart';

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
