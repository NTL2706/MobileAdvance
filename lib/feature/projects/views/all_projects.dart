// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, unnecessary_string_interpolations, must_be_immutable, unused_import, unnecessary_import

import 'package:final_project_advanced_mobile/constants/colors.dart';
import 'dart:async';
import 'package:final_project_advanced_mobile/feature/auth/provider/authenticate_provider.dart';
import 'package:final_project_advanced_mobile/feature/dashboard/constants/time_for_job.dart';
import 'package:final_project_advanced_mobile/feature/dashboard/views/post_a_project/views/project_post_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:provider/provider.dart';
import './project_details.dart';
import './saved_projects.dart';
import './filter_modal.dart';
import './apply_project.dart';
import '../provider/project_provider.dart';
import '../constants/projetcs_type.dart';
import '../utils/convert_days.dart';
import 'dart:async';

class ProjectPage extends StatefulWidget {
  ProjectPage({super.key});

  @override
  State<ProjectPage> createState() => _ProjectPageState();
}

class _ProjectPageState extends State<ProjectPage> {
  Timer? _debounce;

  void onSearchTextChanged() {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      context.read<ProjectProvider>().updateSearch();
    });
  }

  @override
  Widget build(BuildContext context) {
    print("rebuild");
    return Padding(
      padding: EdgeInsets.all(15),
      child: Column(
        children: [
          Padding(
              padding: EdgeInsets.only(bottom: 24.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller:
                          context.read<ProjectProvider>().searchController,
                      onChanged: (value) {
                        onSearchTextChanged();
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        hintText: 'Search projects...',
                        contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                      ),
                    ),
                  ),
                  SizedBox(width: 12),
                  IconButton(
                      constraints:
                          BoxConstraints.tightFor(width: 30, height: 30),
                      iconSize: 30,
                      padding: EdgeInsets.all(0),
                      icon: Consumer(
                        builder: (context, watch, child) => Icon(context
                                .watch<ProjectProvider>()
                                .searchController
                                .text
                                .isNotEmpty
                            ? Icons.filter_list
                            : Icons.favorite),
                      ),
                      onPressed: () {
                        context
                                .read<ProjectProvider>()
                                .searchController
                                .text
                                .isNotEmpty
                            ? showModalBottomSheet(
                                isScrollControlled: true,
                                context: context,
                                builder: (BuildContext context) {
                                  return FilterModal(); // Sử dụng widget FilterModal ở đây
                                },
                              )
                            : Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SavedProjectWidget()),
                              );
                      }),
                ],
              )),
          ShowListProject()
        ],
      ),
    );
  }
}

class ShowListProject extends StatefulWidget {
  const ShowListProject({super.key});

  @override
  State<ShowListProject> createState() => _ShowListProjectState();
}

class _ShowListProjectState extends State<ShowListProject> {
  final controller = ScrollController();
  late ProjectProvider projectProvider;
  late AuthenticateProvider authenticateProvider;
  bool? hasMore = true;
  int page = 1;
  @override
  void initState() {
    super.initState();
    projectProvider = context.read<ProjectProvider>();
    authenticateProvider = context.read<AuthenticateProvider>();
    controller.addListener(() async {
      print("scroll ");
      if (controller.position.maxScrollExtent == controller.offset) {
        setState(() {
          print('scroll di');
          page++;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final role = context.read<AuthenticateProvider>().authenRepository.role;
    return Expanded(
      child: FutureBuilder(
        future: context.watch<ProjectProvider>().getAllProjectForStudent(
            proposalsLessThan: context
                .read<ProjectProvider>()
                .numberOfProposalsController
                .text
                .trim(),
            projectScopeFlag: context
                .read<ProjectProvider>()
                .selectedProjectLength
                .toString(),
            numberOfStudents: context
                .read<ProjectProvider>()
                .numberOfStudentsController
                .text
                .trim(),
            title: context.read<ProjectProvider>().searchController.text.trim(),
            page: page,
            perPage: 5,
            studentId: authenticateProvider.authenRepository.student?['id'],
            token: authenticateProvider.authenRepository.token!),
        builder: (context, snapshot) {
          return FutureBuilder(
            future: projectProvider.checkApply(
                token: authenticateProvider.authenRepository.token!,
                studentId:
                    authenticateProvider.authenRepository.student?['id']),
            builder: (context, snapshot) {
              return ListView.builder(
                controller: controller,
                itemCount: context.read<ProjectProvider>().projects.length + 1,
                itemBuilder: (context, index) {
                  if (index >=
                      context.read<ProjectProvider>().projects.length) {
                    return Padding(
                      padding: EdgeInsets.zero,
                      child: Center(
                        child: context.read<ProjectProvider>().hasMore!
                            ? CircularProgressIndicator()
                            : Center(),
                      ),
                    );
                  } else if (context
                      .watch<ProjectProvider>()
                      .projects
                      .isNotEmpty) {
                    final project =
                        context.watch<ProjectProvider>().projects[index];

                    bool disableFlag = true;
                    final favouriteProjectList =
                        context.read<ProjectProvider>().favouriteProjectList;

                    favouriteProjectList?.forEach(
                      (element) {
                        if (project.id == element['project']['id']) {
                          disableFlag = false;
                        }
                      },
                    );

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
                                    if (role == "student")
                                      IconButton(
                                          onPressed: () async {
                                            setState(() {});
                                            await context
                                                .read<ProjectProvider>()
                                                .toggleFavoriteStatus(
                                                    token: context
                                                        .read<
                                                            AuthenticateProvider>()
                                                        .authenRepository
                                                        .token!,
                                                    studentId: context
                                                        .read<
                                                            AuthenticateProvider>()
                                                        .authenRepository
                                                        .student?['id'],
                                                    projectId: project.id!,
                                                    disableFlag: disableFlag);
                                            // Gọi hàm toggleFavoriteStatus với chỉ số index
                                          },
                                          icon: Icon(
                                            disableFlag
                                                ? // Nếu true, hiển thị biểu tượng favorite đã được tô màu
                                                Icons.favorite_border
                                                : Icons
                                                    .favorite, // Nếu false, hiển thị biểu tượng favorite_border không thay đổi màu sắc
                                            color: Colors
                                                .red, // Thay đổi màu biểu tượng thành màu trắng nếu là favorite, nếu không thì để mặc định
                                          )),
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
                                Text(
                                  'Time: ${optionsTimeForJob[project.time ?? 0]!}',
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
                                      children: [Text(project.describe!)],
                                    )),
                                Divider(
                                  height: 25,
                                  color: Colors.green,
                                  thickness: 1,
                                ),
                                SizedBox(height: 12),
                                Text('${project.countProposals} proposals'),
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
                                                      disableFlag: disableFlag,
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
                                    if (role == "student")
                                      TextButton(
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ApplyProject(
                                                      disableFlag: disableFlag,
                                                      project: project,
                                                    )),
                                          );
                                        },
                                        style: ButtonStyle(
                                          minimumSize:
                                              MaterialStateProperty.all(
                                                  Size(80, 45)),
                                          backgroundColor:
                                              MaterialStateProperty.all<Color>(
                                                  Colors.blue), // Màu nền
                                          shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      10), // Đặt border radius
                                            ),
                                          ),
                                        ),
                                        child: Text(
                                          'Apply',
                                          style: TextStyle(
                                              color:
                                                  Colors.white), // Màu văn bản
                                        ),
                                      ),
                                  ],
                                )
                              ],
                            )));
                  }
                },
              );
            },
          );
        },
      ),
    );
  }
}
