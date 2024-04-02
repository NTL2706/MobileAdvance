

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
  int? numberStudent;
  String? discription;
  int? proposalNumber;
  int? messagesNumber;
  int? HiredNumber;
  String? state = JobState.pending.name;
  JobModel({
    this.id,
    this.HiredNumber,
    this.createAt,
    this.discription,
    this.messagesNumber,
    this.numberStudent,
    this.proposalNumber,
    this.title,
  });

  void updateJob(
    {
      String? title,
      String? createAt,
      int? numberStudent,
      String? discription,
      int? proposalNumber,
      int? messagesNumber,
      int? HiredNumber,
      String? state,
    }){
    this.state = state ?? this.state;
    this.HiredNumber = HiredNumber ?? this.HiredNumber;
    this.discription = discription ?? this.discription;
    this.messagesNumber = messagesNumber ?? this.messagesNumber;
    this.numberStudent = numberStudent ?? this.numberStudent;
    this.title = title ?? this.title;
    this.proposalNumber = proposalNumber ?? this.proposalNumber;

  }
}