import 'package:final_project_advanced_mobile/feature/profie/models/company_profile.dart';

class Profile {
  int id;
  String name;
  List<int> roles;
  StudentProfile? studentProfile;
  Company? company;

  Profile({
    required this.id,
    required this.name,
    required this.roles,
    this.studentProfile,
    this.company,
  });
}

class StudentProfile {
  int id;
  TechStack techStack;
  List<Skill>? skill;
  List<EducationInfo>? educationInfo;
  List<Project>? project;

  StudentProfile({
    required this.id,
    required this.techStack,
    this.skill,
    this.educationInfo,
    this.project,
  });
}

class EducationInfo {
  String schoolName;
  int startYear;
  int endYear;
  int? id;

  EducationInfo({
    this.id,
    required this.schoolName,
    required this.startYear,
    required this.endYear,
  });
}

class TechStack {
  int id;
  String name;

  TechStack({
    required this.id,
    required this.name,
  });
}

class Skill {
  int id;
  String name;

  Skill({
    required this.id,
    required this.name,
  });
}

class Project {
  String name;
  DateTime startDate;
  DateTime endDate;
  String description;
  List<Skill> skillSet;

  Project({
    required this.name,
    required this.startDate,
    required this.endDate,
    required this.description,
    required this.skillSet,
  });
}
