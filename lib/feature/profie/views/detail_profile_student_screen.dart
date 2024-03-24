import 'dart:html';

import 'package:final_project_advanced_mobile/constants/colors.dart';
import 'package:final_project_advanced_mobile/constants/text_style.dart';
import 'package:final_project_advanced_mobile/feature/profie/views/test.dart';
import 'package:flutter/material.dart';
import "package:get/get.dart";

class DetailProfileStudentScreen extends StatefulWidget {
  const DetailProfileStudentScreen({super.key});

  @override
  State<DetailProfileStudentScreen> createState() =>
      _DetailProfileStudentScreenState();
}

class _DetailProfileStudentScreenState
    extends State<DetailProfileStudentScreen> {
  final TextEditingController _controller =
      TextEditingController(text: 'Nguyen Van A');

  String? selectedExpertise = 'Fullstack';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(""),
        elevation: 0,
      ),
      body: Column(
        children: [_appDetailProfileBar(), _appDetailProfile()],
      ),
    );
  }

  Widget _appDetailProfileBar() {
    return Container(
      padding: const EdgeInsets.all(20.0),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 80,
            height: 80,
            child: CircleAvatar(
              backgroundImage: AssetImage("assets/images/logo.png"),
              radius: 40,
            ),
          ),
          SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Nguyen Van A",
                style: AppTextStyles.headerStyle,
              ),
              Text("HCMUS", style: AppTextStyles.bodyStyle),
              Text("Student", style: AppTextStyles.bodyStyle),
            ],
          ),
        ],
      ),
    );
  }

  Widget _appDetailProfile() {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(20.0),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          ),
          color: AppColors.backgroundColor,
        ),
        child: ListView(
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    // builder: (context) => const DetailProfileCompanyScreen(),
                    builder: (context) => SkillsetInputView(),
                  ),
                );
              },
              child: Text('Update'),
            ),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _controller,
                    enabled: false,
                    decoration: const InputDecoration(
                      labelText: 'Number of Employees',
                      labelStyle: AppTextStyles.bodyStyle,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    print('Edit button pressed');
                    showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return StatefulBuilder(
                          builder: (context, setState) {
                            return Container(
                              child: FractionallySizedBox(
                                heightFactor: 1,
                                widthFactor: 1,
                                child: Container(
                                  padding: EdgeInsets.all(20),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      const Text(
                                        'Select teckstack:',
                                        style: AppTextStyles.headerStyle,
                                      ),
                                      const SizedBox(height: 20),
                                      DropdownButton<String>(
                                        value: selectedExpertise,
                                        icon: const Icon(Icons.arrow_downward),
                                        elevation: 16,
                                        style: AppTextStyles.bodyStyle,
                                        underline: Container(
                                          height: 2,
                                          color: Colors.deepPurpleAccent,
                                        ),
                                        onChanged: (String? value) {
                                          setState(() {
                                            selectedExpertise = value!;
                                          });
                                        },
                                        // list of items
                                        items: <String>[
                                          'Fullstack',
                                          'Mobile',
                                          'Backend',
                                          'Frontend',
                                          'DevOps',
                                          'QA',
                                          'Other'
                                        ].map<DropdownMenuItem<String>>(
                                            (String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                          );
                                        }).toList(),
                                      ),
                                      SizedBox(height: 20),
                                      ElevatedButton(
                                        onPressed: () {
                                          // Add your update logic here
                                          Navigator.pop(context);
                                        },
                                        child: Text('Update'),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
