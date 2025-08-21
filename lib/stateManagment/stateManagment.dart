
// App State Management
import 'package:flutter/material.dart';
import 'package:fristonevs/data_model/therapyProgram.dart';
import 'package:fristonevs/main.dart';

class AppState with ChangeNotifier {
  UserProfile? _userProfile;
  final IUserRepository _userRepository;
  
  AppState(this._userRepository);
  
  UserProfile? get userProfile => _userProfile;
  
  Future<void> loadUserProfile() async {
    _userProfile = await _userRepository.getUserProfile();
    notifyListeners();
  }
  
  Future<void> updateUserProfile(UserProfile profile) async {
    await _userRepository.updateUserProfile(profile);
    _userProfile = profile;
    notifyListeners();
  }
}
