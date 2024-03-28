// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, unnecessary_string_interpolations, must_be_immutable, unused_import, unnecessary_import

import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import './project_details.dart';
import '../provider/project_provider.dart';
import '../constants/projetcs_type.dart';
import '../utils/convert_days.dart';

class SavedProjectWidget extends StatefulWidget {
  const SavedProjectWidget({super.key});

  @override
  State<SavedProjectWidget> createState() => _ProjectWidgetState();
}

class _ProjectWidgetState extends State<SavedProjectWidget> {
  @override
  Widget build(BuildContext context) {
    final projectProvider = Provider.of<ProjectProvider>(context);
    return Scaffold(
        appBar: AppBar(
          scrolledUnderElevation: 0,
          title: Text('Saved Projects'),
        ),
        body: Padding(
          padding: EdgeInsets.all(24),
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: projectProvider.projects
                      .where((project) => project.isFavourite == true)
                      .toList()
                      .length,
                  itemBuilder: (context, index) {
                    final project = projectProvider.projects
                        .where((project) => project.isFavourite == true)
                        .toList()[index];
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
                                    // Thời gian của animation
                                    IconButton(
                                        onPressed: () {
                                          projectProvider
                                              .toggleFavoriteStatus(project.id);
                                        },
                                        icon: Icon(
                                          project.isFavourite
                                              ? Icons
                                                  .favorite // Nếu true, hiển thị biểu tượng favorite đã được tô màu
                                              : Icons
                                                  .favorite_border, // Nếu false, hiển thị biểu tượng favorite_border không thay đổi màu sắc
                                          color: project.isFavourite
                                              ? Colors.red
                                              : null, // Thay đổi màu biểu tượng thành màu trắng nếu là favorite, nếu không thì để mặc định
                                        )),
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
                                      onPressed: () {},
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
