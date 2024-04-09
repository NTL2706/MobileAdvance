import 'package:final_project_advanced_mobile/feature/profie/models/student_profile.dart';

class Profile {
  final int id;
  final String name;
  final List<int> roles;
  final StudentProfile? studentProfile;

  Profile({
    required this.id,
    required this.name,
    required this.roles,
    this.studentProfile,
  });
}
