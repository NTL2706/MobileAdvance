import 'package:final_project_advanced_mobile/utils/http_response.dart';

class Project {
  int? id;
  String? title;
  DateTime? createdAt;
  int? numberOfPeople;
  int? time;
  int? countProposals;
  String? describe;
  bool? isFavourite;

  Project(
      {this.id,
      this.title,
      this.createdAt,
      this.numberOfPeople,
      this.countProposals,
      this.time,
      this.describe,
      this.isFavourite = false});

  factory Project.fromJson(Map<String, dynamic>? json) {
    return Project(
        id: json?['id'],
        title: json?['title'],
        createdAt: DateTime.parse(json?['createdAt']),
        numberOfPeople: json?['numberOfStudents'],
        time: json?['projectScopeFlag'],
        describe: json?['description'],
        countProposals: json?['countProposals'],
        isFavourite: json?['isFavourite']);
  }
}
