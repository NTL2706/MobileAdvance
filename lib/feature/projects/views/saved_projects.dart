// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, unnecessary_string_interpolations, must_be_immutable, unused_import, unnecessary_import

import 'package:final_project_advanced_mobile/constants/colors.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import './project_details.dart';
import '../provider/project_provider.dart';
import '../constants/projetcs_type.dart';
import '../utils/convert_days.dart';

class SavedProjectWidget extends StatefulWidget {
  SavedProjectWidget({super.key});

  @override
  State<SavedProjectWidget> createState() => _ProjectWidgetState();
}

class _ProjectWidgetState extends State<SavedProjectWidget> {
  @override
  Widget build(BuildContext context) {
    final favouritedProjectList =
        context.read<ProjectProvider>().favouriteProjectList;
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
                  itemCount: favouritedProjectList?.length,
                  itemBuilder: (context, index) {
                    final project = Project.fromJson(
                        (favouritedProjectList?[index])?['project']);
                    return Container(
                        margin: EdgeInsets.only(bottom: 24.0),
                        decoration: BoxDecoration(
                          color: Get.isDarkMode
                              ? Themes.boxDecorationDark.withOpacity(0.5)
                              : Themes.boxDecorationLight
                                  .withOpacity(0.5), // Màu xám
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
                                    // IconButton(
                                    //     onPressed: () {

                                    //     },
                                    //     icon: Icon(
                                    //       project.isFavourite!
                                    //           ? Icons
                                    //               .favorite // Nếu true, hiển thị biểu tượng favorite đã được tô màu
                                    //           : Icons
                                    //               .favorite_border, // Nếu false, hiển thị biểu tượng favorite_border không thay đổi màu sắc
                                    //       color: project.isFavourite!
                                    //           ? Colors.red
                                    //           : null, // Thay đổi màu biểu tượng thành màu trắng nếu là favorite, nếu không thì để mặc định
                                    //     )),
                                  ],
                                ),
                                SizedBox(height: 12),
                                Text(
                                  project.title!,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 12),
                                Text(
                                  'Created: ${formatDate(project.createdAt!)}',
                                ),
                                SizedBox(height: 12),
                                Text(
                                  'Student needed: ${project.numberOfPeople}',
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                                SizedBox(height: 12),
                                // Text(
                                //   'Time: ${project.time.join(' - ')} ${project.time.length > 1 || project.time[0] > 1 ? ' months' : ' month'}',
                                //   overflow: TextOverflow.ellipsis,
                                //   maxLines: 1,
                                // ),
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
                                      children: [Text(project.describe!)],
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
                                                      disableFlag: false,
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
