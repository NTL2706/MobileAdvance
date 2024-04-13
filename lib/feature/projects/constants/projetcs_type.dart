import 'package:final_project_advanced_mobile/utils/http_response.dart';

class Project {
  int? id;
  String? title;
  DateTime? createdAt;
  int? numberOfPeople;
  int? time;
  String? describe;
  bool? isFavourite;

  Project(
      {this.id,
      this.title,
      this.createdAt,
      this.numberOfPeople,
      this.time,
      this.describe,
      this.isFavourite = false});

  factory Project.fromJson(Map<String, dynamic>? json) {
    return Project(
        id: json?['projectId'],
        title: json?['title'],
        createdAt: DateTime.parse(json?['createdAt']),
        numberOfPeople: json?['numberOfStudents'],
        time: json?['projectScopeFlag'],
        describe: json?['description'],
        isFavourite: json?['isFavourite']);
  }
}
