
// User Repository Implementation
import 'package:fristonevs/data_model/therapyProgram.dart';
import 'package:fristonevs/main.dart';

class UserRepository implements IUserRepository {
  @override
  Future<UserProfile> getUserProfile() async {
    // Simulate fetching user data
    await Future.delayed(const Duration(milliseconds: 500));
    
    return UserProfile(
      name: 'Ahmed Hassan',
      city: 'Cairo',
      age: 32,
      fitnessLevel: 'Intermediate',
      imageUrl: 'https://randomuser.me/api/portraits/men/1.jpg',
    );
  }

  @override
  Future<void> updateUserProfile(UserProfile profile) async {
    // Simulate updating user data
    await Future.delayed(const Duration(milliseconds: 500));
    print('Profile updated: ${profile.name}');
  }
}
