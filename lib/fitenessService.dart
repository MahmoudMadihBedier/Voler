import 'package:flutter/material.dart';
import 'package:fristonevs/data_model/therapyProgram.dart';
import 'package:fristonevs/stateManagment/abstractServices.dart';
import 'package:fristonevs/theme/theme.dart';

class FitnessService implements IFitnessService {
  @override
  Future<List<FitnessProgram>> getFitnessPrograms() async {
    // Simulate API call
    await Future.delayed(const Duration(seconds: 1));
    
    return [
      FitnessProgram(
        'High Intensity Training',
        '25 min • 320 cal',
        Icons.fitness_center,
        AppConstants.primaryColor,
        'Advanced',
      ),
      FitnessProgram(
        'Yoga & Flexibility',
        '40 min • 180 cal',
        Icons.self_improvement,
        AppConstants.secondaryColor,
        'Beginner',
      ),
      FitnessProgram(
        'Cardio Blast',
        '30 min • 400 cal',
        Icons.directions_run,
        Colors.pink,
        'Intermediate',
      ),
      FitnessProgram(
        'Egyptian Belly Dancing Fitness',
        '35 min • 280 cal',
        Icons.music_note,
        Colors.purple,
        'All Levels',
      ),
    ];
  }
}
