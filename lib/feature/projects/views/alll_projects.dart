// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, unnecessary_string_interpolations

import 'package:flutter/material.dart';
import './project_details.dart';
import '../constants/projetcs_type.dart';
import '../utils/convert_days.dart';

class ProjectWidget extends StatefulWidget {
  final List<Project> projects;

  ProjectWidget(this.projects, {super.key});

  @override
  State<ProjectWidget> createState() => _ProjectWidgetState();
}

class _ProjectWidgetState extends State<ProjectWidget> {
  final TextEditingController _searchController = TextEditingController();
  late List<Project> filteredProjects = [];
  late List<String> filter = [];

  @override
  void initState() {
    super.initState();
    filteredProjects = widget.projects;
  }

  void updateSearch(String value) {
    setState(() {
      if (value.isNotEmpty) {
        List<Project> filteredList = widget.projects
            .where((project) =>
                project.name.toLowerCase().contains(value.toLowerCase()))
            .toList();
        if (filteredList == []) {
          filteredProjects == [];
        } else {
          filteredProjects = filteredList;
        }
      } else {
        filteredProjects = widget.projects;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          scrolledUnderElevation: 0,
          title: Text('Browse Projects'),
        ),
        body: Padding(
          padding: EdgeInsets.all(24),
          child: Column(
            children: [
              Padding(
                  padding: EdgeInsets.only(bottom: 24.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _searchController,
                          onChanged: (value) {
                            updateSearch(value);
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0),
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            hintText: 'Search projects...',
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 16.0),
                          ),
                        ),
                      ),
                      SizedBox(width: 12),
                      IconButton(
                        constraints:
                            BoxConstraints.tightFor(width: 30, height: 30),
                        iconSize: 30,
                        padding: EdgeInsets.all(0),
                        icon: Icon(_searchController.text.isNotEmpty
                            ? Icons.filter_list
                            : Icons.favorite),
                        onPressed: () {},
                      ),
                    ],
                  )),
              Expanded(
                child: ListView.builder(
                  itemCount: filteredProjects.length,
                  itemBuilder: (context, index) {
                    final project = filteredProjects.isNotEmpty
                        ? filteredProjects[index]
                        : widget.projects[index];
                    return Container(
                        margin: EdgeInsets.only(bottom: 24.0),
                        decoration: BoxDecoration(
                          color: Colors.grey[300], // Màu xám
                          borderRadius:
                              BorderRadius.circular(12.0), // Góc bo tròn
                        ),
                        child: Padding(
                            padding: EdgeInsets.all(12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(
                                          12.0), // Đặt border radius là 12.0
                                      child: Image.asset(
                                        'assets/images/logo.png', // Thay 'assets/your_image.png' bằng đường dẫn đến hình ảnh của bạn
                                        width: 70,
                                        height: 70,
                                      ),
                                    ),
                                    IconButton(
                                      icon: Icon(Icons.favorite_border),
                                      onPressed: () {
                                        // Handle like button press
                                      },
                                    ),
                                  ],
                                ),
                                SizedBox(height: 12),
                                Text(
                                  project.name,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 12),
                                Text(
                                  'Created: ${formatDate(project.createdAt)}',
                                ),
                                SizedBox(height: 12),
                                Text(
                                  'Student needed: ${project.numberOfPeople}',
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                                SizedBox(height: 12),
                                Text(
                                  'Time: ${project.time.join(' - ')} ${project.time.length > 1 || project.time[0] > 1 ? ' months' : ' month'}',
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                                SizedBox(height: 12),
                                Text(
                                  'Details:',
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                                Padding(
                                    padding: EdgeInsets.only(
                                        left: 12.0, right: 12.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        ...project.describe
                                            .take(3)
                                            .map((description) => Text(
                                                  '\u2022 $description',
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 1,
                                                ))
                                            .toList(),
                                        if (project.describe.length > 3)
                                          Text(
                                            '...',
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 24),
                                          ),
                                      ],
                                    )),
                                Divider(
                                  height: 25,
                                  color: Colors.green,
                                  thickness: 1,
                                ),
                                SizedBox(height: 12),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ProjectDetailScreen(
                                                      project: project)),
                                        );
                                      },
                                      style: ButtonStyle(
                                        minimumSize: MaterialStateProperty.all(
                                            Size(140, 45)), // Kích thước nút
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                                Colors.blue), // Màu nền
                                        shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                10), // Đặt border radius
                                          ),
                                        ),
                                      ),
                                      child: Text(
                                        'Views Details',
                                        style: TextStyle(
                                            color: Colors.white), // Màu văn bản
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        // Xử lý khi nút được nhấn
                                      },
                                      style: ButtonStyle(
                                        minimumSize: MaterialStateProperty.all(
                                            Size(80, 45)),
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                                Colors.blue), // Màu nền
                                        shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                10), // Đặt border radius
                                          ),
                                        ),
                                      ),
                                      child: Text(
                                        'Apply',
                                        style: TextStyle(
                                            color: Colors.white), // Màu văn bản
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            )));
                  },
                ),
              ),
            ],
          ),
        ));
  }
}

void main() {
  List<Project> projects = [
    Project(
      'Project A',
      DateTime(2023, 10, 15),
      20,
      [1],
      [
        'Description A1 Description A1 Description A1 Description A1 Description A1 Description A1',
        'Description A2',
        'Description A3'
      ],
    ),
    Project(
      'Project B',
      DateTime(2024, 2, 28),
      15,
      [1, 2],
      ['Description B1', 'Description B2'],
    ),
    Project(
      'Project C',
      DateTime(2024, 3, 5),
      30,
      [2, 3],
      ['Description C1', 'Description C2', 'Description C3', 'Description C4'],
    ),
    Project(
      'Project D',
      DateTime(2024, 1, 10),
      25,
      [4],
      ['Description D1'],
    ),
    Project(
      'Project E',
      DateTime(2024, 4, 1),
      18,
      [5, 9],
      [
        'Description E1',
        'Description E2',
        'Description E3',
        'Description E4',
        'Description E5',
        'Description E6'
      ],
    ),
  ];

  runApp(MaterialApp(
    home: ProjectWidget(projects),
  ));
}
