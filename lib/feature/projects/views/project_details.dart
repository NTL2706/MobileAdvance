// ignore_for_file: prefer_const_constructors, unused_import

import 'package:final_project_advanced_mobile/feature/dashboard/views/post_a_project/views/project_post_2.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants/projetcs_type.dart';
import '../utils/convert_days.dart';
import '../provider/project_provider.dart';
import './apply_project.dart';

class ProjectDetailScreen extends StatelessWidget {
  final Project project;
  bool disableFlag;

  ProjectDetailScreen(
      {required this.disableFlag, super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(project.title!),
        ),
        body: Padding(
          padding: EdgeInsets.all(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: 24),
                  Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12.0),
                      child: Image.asset(
                        'assets/images/logo.png', // Thay đổi thành đường dẫn của hình ảnh dự án
                        width: 150,
                        height: 150,
                      ),
                    ),
                  ),
                  SizedBox(height: 24),
                  Text(
                    'Description: ',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [Text(project.describe!)]),
                  SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.people,
                        size: 30,
                      ),
                      SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Student needed : ',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Padding(
                              padding: EdgeInsets.only(left: 12),
                              child: Text(
                                  '\u2022 ${project.numberOfPeople} ${project.numberOfPeople! > 1 ? 'students' : 'student'}'))
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.access_time,
                        size: 30,
                      ),
                      SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Time : ',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 12),
                            child: Text(
                              'Time: ${optionsTimeForJob[project.time]!}',
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      // projectProvider.toggleFavoriteStatus(project.id);
                    },
                    style: ButtonStyle(
                      minimumSize: MaterialStateProperty.all(
                          Size(150, 55)), // Kích thước nút
                      backgroundColor: MaterialStateProperty.all<Color>(
                          disableFlag ? Colors.blue : Colors.red), // Màu nền
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(10), // Đặt border radius
                        ),
                      ),
                    ),
                    child: Text(
                      disableFlag ? 'Save' : 'Saved',
                      style: TextStyle(color: Colors.white), // Màu văn bản
                    ),
                  ),
                  SizedBox(width: 24),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ApplyProject(
                                  project: project,
                                  disableFlag: disableFlag,
                                )),
                      );
                    },
                    style: ButtonStyle(
                      minimumSize: MaterialStateProperty.all(Size(150, 55)),
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Colors.blue), // Màu nền
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(10), // Đặt border radius
                        ),
                      ),
                    ),
                    child: Text(
                      'Apply',
                      style: TextStyle(color: Colors.white), // Màu văn bản
                    ),
                  ),
                ],
              )
            ],
          ),
        ));
  }
}
