import 'package:final_project_advanced_mobile/feature/profie/models/skill.dart';

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
