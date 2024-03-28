import 'dart:ffi';

import 'package:flutter/material.dart';

class JobModel{
  static TextEditingController titleController = TextEditingController();
  static TextEditingController timeForProjectController = TextEditingController();
  static TextEditingController numberStudentController = TextEditingController();
  static TextEditingController discriptionController = TextEditingController();

  String? title;
  String? createAt;
  int? numberStudent;
  String? discription;
  int? proposalNumber;
  int? messagesNumber;
  int? HiredNumber;

  JobModel({
    this.HiredNumber,
    this.createAt,
    this.discription,
    this.messagesNumber,
    this.numberStudent,
    this.proposalNumber,
    this.title,
  });
}