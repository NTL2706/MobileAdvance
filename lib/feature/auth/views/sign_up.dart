// ignore_for_file: must_be_immutable, prefer_const_constructors, sized_box_for_whitespace

import 'dart:async';

import 'package:final_project_advanced_mobile/feature/auth/constants/auth_result.dart';
import 'package:final_project_advanced_mobile/feature/auth/constants/sigup_category.dart';
import 'package:final_project_advanced_mobile/feature/auth/provider/authenticate_provider.dart';
import 'package:final_project_advanced_mobile/languages/language.dart';
import 'package:final_project_advanced_mobile/widgets/custom_textfield.dart';
import 'package:final_project_advanced_mobile/widgets/password_textfield.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/quickalert.dart';

class SignUpForStudentOrCompany extends StatelessWidget {
  SignUpForStudentOrCompany({super.key, required this.title});

  StreamController checkBoxStreamController = StreamController();
  TextEditingController fullNameSignUpController = TextEditingController();
  TextEditingController emailSignUpController = TextEditingController();
  TextEditingController passwordSignUpController = TextEditingController();
  final String title;

  @override
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
                  Languages.of(context)!.register +
                      " " +
                      Languages.of(context)!.student,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              CustomTextField(
                  onChanged: (p0) {},
                  controller: fullNameSignUpController,
                  hintText: Languages.of(context)!.fullName),
              const SizedBox(height: 10),
              CustomTextField(
                onChanged: (p0) {},
                controller: emailSignUpController,
                hintText: Languages.of(context)!.email,
              ),
              const SizedBox(height: 10),
              PasswordFielddWidget(
                controller: passwordSignUpController,
              ),
              Row(
                children: [
                  CustomCheckBox(
                    checkBoxStreamController: checkBoxStreamController,
                  ),
                  Text(Languages.of(context)!.agree),
                ],
              ),
              Container(
                  width: size.width * 0.7,
                  child: StreamBuilder(
                      initialData: false,
                      stream: checkBoxStreamController.stream,
                      builder: (context, snapshot) {
                        bool check = snapshot.data!;
                        return ElevatedButton(
                            onPressed: check
                                ? () async {
                                    if (title ==
                                        StudentHubCategorySignUp.student.name) {
                                      await context
                                          .read<AuthenticateProvider>()
                                          .signUpWithPassword(
                                              email: emailSignUpController.text
                                                  .trim(),
                                              password: passwordSignUpController
                                                  .text
                                                  .trim(),
                                              fullname:
                                                  fullNameSignUpController.text,
                                              role: StudentHubCategorySignUp
                                                  .values[0].index);
                                    } else {
                                      await context
                                          .read<AuthenticateProvider>()
                                          .signUpWithPassword(
                                              email: emailSignUpController.text
                                                  .trim(),
                                              password: passwordSignUpController
                                                  .text
                                                  .trim(),
                                              fullname:
                                                  fullNameSignUpController.text,
                                              role: StudentHubCategorySignUp
                                                  .values[1].index);
                                    }

                                    final results = context
                                        .read<AuthenticateProvider>()
                                        .state
                                        .result;

                                    await QuickAlert.show(
                                        text: context
                                            .read<AuthenticateProvider>()
                                            .state
                                            .message,
                                        confirmBtnText:
                                            Languages.of(context)!.oke,
                                        cancelBtnText:
                                            Languages.of(context)!.cancel,
                                        onConfirmBtnTap: results ==
                                                AuthResult.success
                                            ? () {
                                                Navigator.of(context).popUntil(
                                                    ModalRoute.withName(
                                                        "/intro"));
                                              }
                                            : () {
                                                Navigator.of(context).pop();
                                              },
                                        onCancelBtnTap: () {
                                          Navigator.of(context).pop();
                                        },
                                        context: context,
                                        showCancelBtn: true,
                                        type: results == AuthResult.success
                                            ? QuickAlertType.success
                                            : QuickAlertType.error);
                                    checkBoxStreamController.add(false);
                                  }
                                : null,
                            child: context
                                    .watch<AuthenticateProvider>()
                                    .state
                                    .isLoading
                                ? CircularProgressIndicator()
                                : Text(Languages.of(context)!.register));
                      })),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(Languages.of(context)!.lookProject + " "),
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
                            "${Languages.of(context)!.apply} ${Languages.of(context)!.company}",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )
                        : Text(
                            "${Languages.of(context)!.apply} ${Languages.of(context)!.student}",
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
