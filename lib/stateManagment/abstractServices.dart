// Abstract Service Classes (following Dependency Inversion Principle)
import 'package:fristonevs/data_model/therapyProgram.dart';

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
