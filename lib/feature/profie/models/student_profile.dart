import 'package:final_project_advanced_mobile/feature/profie/models/education_info.dart';
import 'package:final_project_advanced_mobile/feature/profie/models/skill.dart';
import 'package:final_project_advanced_mobile/feature/profie/models/techstack.dart';

class StudentProfile {
  final int id;
  final TechStack techStack;
  final List<Skill> skill;
  final List<EducationInfo>? educationInfo;

  StudentProfile(
      {required this.id,
      required this.techStack,
      required this.skill,
      this.educationInfo});
}
