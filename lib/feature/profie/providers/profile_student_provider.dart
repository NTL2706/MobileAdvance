import 'package:final_project_advanced_mobile/feature/profie/models/skill.dart';
import 'package:final_project_advanced_mobile/feature/profie/models/techstack.dart';
import 'package:final_project_advanced_mobile/feature/profie/repo/profile_repo.dart';

class ProfileStudentProvider {
  final ProfileRepository profileRepo = ProfileRepository();

  List<Skill> skills = [];
  List<TechStack> techStack = [];

  ProfileStudentProvider();

  Future<void> getTechStackDefault() async {
    try {
      var fetchedTechStack = await profileRepo.getTechStackDefault();
      techStack = fetchedTechStack;
    } catch (e) {
      print('Failed to get tech stack default: $e');
    }
  }

  Future<void> getSkillsDefault() async {
    try {
      var fetchedSkills = await profileRepo.getSkillDefault();
      skills = fetchedSkills;
    } catch (e) {
      print('Failed to get skills: $e');
    }
  }

  Future<void> updateProfileStudent(data) async {
    try {
      await profileRepo.updateProfileStudent(data);
    } catch (e) {
      print('Failed to update profile student: $e');
    }
  }
}
