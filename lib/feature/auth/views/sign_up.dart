// ignore_for_file: must_be_immutable, prefer_const_constructors, sized_box_for_whitespace

import 'dart:async';

import 'package:final_project_advanced_mobile/feature/auth/constants/sigup_category.dart';
import 'package:final_project_advanced_mobile/widgets/custom_textfield.dart';
import 'package:final_project_advanced_mobile/widgets/password_textfield.dart';
import 'package:flutter/material.dart';

class SignUpForStudentOrCompany extends StatelessWidget {
  SignUpForStudentOrCompany({super.key, required this.title});

  StreamController checkBoxStreamController = StreamController();

  final String title;

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Center(
                child: Text(
                  "Sign up as ${title}",
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              CustomTextField(hintText: "Fullname"),
              SizedBox(height: 10),
              CustomTextField(
                hintText: "Work email address",
              ),
              SizedBox(height: 10),
              PasswordFielddWidget(),
              Row(
                children: [
                  CustomCheckBox(
                    checkBoxStreamController: checkBoxStreamController,
                  ),
                  Text("Yes, i understand and agree to StudentHub")
                ],
              ),
              Container(
                  width: size.width / 2,
                  child: StreamBuilder(
                      initialData: false,
                      stream: checkBoxStreamController.stream,
                      builder: (context, snapshot) {
                        bool check = snapshot.data!;
                        return ElevatedButton(
                            onPressed: check
                                ? () {
                                    if (title ==
                                        StudentHubCategorySignUp.student.name) {
                                      print("api for sign up student");
                                    } else {
                                      print("api for sign up company");
                                    }
                                  }
                                : null,
                            child: Text("SIGN UP"));
                      })),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Looking for a project? "),
                  GestureDetector(
                    onTap: () {
                      if (title == "student") {
                        Navigator.pushReplacement(context, MaterialPageRoute(
                          builder: (context) {
                            return SignUpForStudentOrCompany(
                              title: "company",
                            );
                          },
                        ));
                      } else {
                        Navigator.pushReplacement(context, MaterialPageRoute(
                          builder: (context) {
                            return SignUpForStudentOrCompany(
                              title: "student",
                            );
                          },
                        ));
                      }
                    },
                    child: title == "student"
                        ? Text(
                            "Apply as company",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )
                        : Text(
                            "Apply as student",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CustomCheckBox extends StatefulWidget {
  final StreamController checkBoxStreamController;
  bool checkBoxValue = false;
  CustomCheckBox({super.key, required this.checkBoxStreamController});

  @override
  State<CustomCheckBox> createState() => _CustomCheckBoxState();
}

class _CustomCheckBoxState extends State<CustomCheckBox> {
  @override
  Widget build(BuildContext context) {
    return Checkbox(
      value: widget.checkBoxValue,
      onChanged: (value) {
        widget.checkBoxStreamController.add(value);
        setState(() {
          widget.checkBoxValue = !(widget.checkBoxValue);
        });
      },
    );
  }
}
