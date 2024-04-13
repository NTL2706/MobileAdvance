

import 'package:flutter/material.dart';

enum JobState{
  working,
  pending,
  archieved
}
class JobModel{
  static TextEditingController titleController = TextEditingController();
  static TextEditingController timeForProjectController = TextEditingController();
  static TextEditingController numberStudentController = TextEditingController();
  static TextEditingController discriptionController = TextEditingController();
  int? id;
  String? title;
  String? createAt;
  String? deletedAt;
  String? updateAt;
  String? description;
  String? companyId;
  int?numberOfStudents;
  int? projectScopeFlag;
  int? typeFlag;
  int?proposalNumber = 0;
  int?messagesNumber= 0;
  int?hiredNumber = 0;
  List<Map<String,dynamic>>? proposals;
  String? state = JobState.pending.name;
  JobModel({
    this.id,
    this.createAt,
    this.description,
    this.title,
    this.companyId,
    this.deletedAt,
    this.projectScopeFlag,
    this.numberOfStudents,
    this.typeFlag,
    this.updateAt,
    this.proposalNumber,
    this.messagesNumber,
    this.hiredNumber,
    this.proposals
  });

  void updateJob(
    {
      int? id,
      String? title,
      String? createAt,
      String? deletedAt,
      String? updateAt,
      String? description,
      String? companyId,
      int?numberOfStudents,
      int? projectScopeFlag,
      int? typeFlag,

    }){
    this.state = state ?? this.state;
    this.companyId = companyId ?? this.companyId;
    this.description = description ?? this.description;
    this.createAt = createAt ?? this.createAt;
    this.updateAt = updateAt ?? this.updateAt;
    this.deletedAt = deletedAt ?? this.deletedAt;
    this.title = title ?? this.title;
    this.numberOfStudents = numberOfStudents ?? this.numberOfStudents;
    this.typeFlag = typeFlag ?? this.typeFlag;
    this.projectScopeFlag = projectScopeFlag ?? this.projectScopeFlag;
  }

  factory JobModel.jsonFrom(Map<String,dynamic>json) {
    return JobModel(
      id: json['id'],
      createAt: json['createdAt'],
      updateAt: json['updatedAt'],
      deletedAt: json['deletedAt'],
      companyId: json['companyId'],
      projectScopeFlag: json['projectScopeFlag'],
      title: json['title'],
      description: json['description'],
      numberOfStudents: json['numberOfStudents'],
      typeFlag: json['typeFlag'],
      proposalNumber: json['countProposals'],
      hiredNumber: json['countHired'],
      messagesNumber: json['countMessages'],
      proposals:List<Map<String,dynamic>>.from(json['proposals'])
    );
  }
}