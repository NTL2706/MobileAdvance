import 'package:final_project_advanced_mobile/feature/profie/models/profile.dart';
import 'package:final_project_advanced_mobile/feature/profie/repo/profile_repo.dart';

class ProfileProvider {
  final ProfileRepository profileRepo = ProfileRepository();

  ProfileProvider();

  Profile? profile = null;

  Future<void> getProfileUser() async {
    try {
      var fetchProfile = await profileRepo.getProfileUser();
      profile = fetchProfile;
    } catch (e) {
      print('Failed to get profile user: $e');
    }
  }
}
