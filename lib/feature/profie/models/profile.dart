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

class StudentProfile {
  final int id;
  final String name;
  final TechStack techStack;
  final List<Skill>? skill;
  final List<EducationInfo>? educationInfo;

  StudentProfile({
    required this.id,
    required this.name,
    required this.techStack,
    this.skill,
    this.educationInfo,
  });
}

class EducationInfo {
  String schoolName;
  int startYear;
  int endYear;
  int id;

  EducationInfo({
    required this.id,
    required this.schoolName,
    required this.startYear,
    required this.endYear,
  });
}

class TechStack {
  final int id;
  final String name;

  TechStack({
    required this.id,
    required this.name,
  });
}

class Skill {
  final int id;
  final String name;

  Skill({
    required this.id,
    required this.name,
  });
}
