// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import '../constants/projetcs_type.dart';
import '../utils/convert_days.dart';

class ProjectDetailScreen extends StatelessWidget {
  final Project project;

  const ProjectDetailScreen({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(project.name),
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
                    children: project.describe.map((description) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 8.0, left: 12.0),
                        child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('\u2022'),
                              SizedBox(width: 8),
                              Expanded(
                                  child: Text(description,
                                      overflow: TextOverflow.visible)),
                            ]),
                      );
                    }).toList(),
                  ),
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
                                  '\u2022 ${project.numberOfPeople} ${project.numberOfPeople > 1 ? 'students' : 'student'}'))
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
                              '\u2022 ${project.time.join(' - ')} ${project.time.length > 1 || project.time[0] > 1 ? ' months' : ' month'}',
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
                    onPressed: () {},
                    style: ButtonStyle(
                      minimumSize: MaterialStateProperty.all(
                          Size(150, 55)), // Kích thước nút
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
                      'Saved',
                      style: TextStyle(color: Colors.white), // Màu văn bản
                    ),
                  ),
                  SizedBox(width: 24),
                  TextButton(
                    onPressed: () {},
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
