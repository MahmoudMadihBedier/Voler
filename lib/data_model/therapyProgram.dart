// Data Models
import 'package:flutter/material.dart';

class TherapyProgram {
  final String title;
  final String description;
  final IconData icon;
  final Color color;
  final int duration; // in minutes

  TherapyProgram(this.title, this.description, this.icon, this.color, this.duration);
}

class FitnessProgram {
  final String title;
  final String description;
  final IconData icon;
  final Color color;
  final String difficulty;

  FitnessProgram(this.title, this.description, this.icon, this.color, this.difficulty);
}

class UserProfile {
  final String name;
  final String city;
  final int age;
  final String fitnessLevel;
  final String imageUrl;

  UserProfile({
    required this.name,
    required this.city,
    required this.age,
    required this.fitnessLevel,
    required this.imageUrl,
  });
}
