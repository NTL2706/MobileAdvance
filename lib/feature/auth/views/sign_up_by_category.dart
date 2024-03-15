// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, avoid_unnecessary_containers, sized_box_for_whitespace, avoid_print

import 'package:final_project_advanced_mobile/feature/auth/constants/sigup_category.dart';
import 'package:final_project_advanced_mobile/feature/auth/views/sign_up.dart';
import 'package:flutter/material.dart';

class SignUpByCategory extends StatefulWidget {
  @override
  State<SignUpByCategory> createState() => _SignUpByCategoryState();
}

class _SignUpByCategoryState extends State<SignUpByCategory> {
  String selectedCategorySignUp = "";
  bool checkBoxStudent = false;
  bool checkBoxCompany = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child: Center(
            child: Column(
              children: [
                Text(
                  "Join as company or student",
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: Colors.black)),
                  child: ListTile(
                    title: Container(
                        alignment: Alignment.topLeft,
                        child: Icon(Icons.person)),
                    subtitle: Text("I am student"),
                    trailing: Checkbox(
                      onChanged: (value) {
                        if (value!) {
                          selectedCategorySignUp =
                              StudentHubCategorySignUp.student.name;
                        } else {
                          selectedCategorySignUp = "";
                        }
                        setState(() {
                          checkBoxStudent = !checkBoxStudent;
                          checkBoxCompany = false;
                        });
                      },
                      value: checkBoxStudent,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: Colors.black)),
                  child: ListTile(
                      title: Container(
                          alignment: Alignment.topLeft,
                          child: ImageIcon(
                              AssetImage("assets/icons/business.png"))),
                      subtitle: Text("I am company"),
                      trailing: Checkbox(
                        onChanged: (value) {
                          if (value!) {
                            selectedCategorySignUp =
                                StudentHubCategorySignUp.company.name;
                          } else {
                            selectedCategorySignUp = "";
                          }
                          setState(() {
                            checkBoxStudent = false;
                            checkBoxCompany = !checkBoxCompany;
                          });
                        },
                        value: checkBoxCompany,
                      )),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: size.width / 2,
                  child: ElevatedButton(
                    onPressed: () {
                      print(selectedCategorySignUp);
                      if (selectedCategorySignUp != "") {
                        Navigator.pushReplacement(context, MaterialPageRoute(
                          builder: (context) {
                            return SignUpForStudentOrCompany(
                              title: selectedCategorySignUp,
                            );
                          },
                        ));
                      }
                    },
                    child: Text("Create account"),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
