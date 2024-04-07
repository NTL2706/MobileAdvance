// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, unnecessary_string_interpolations, must_be_immutable, unused_import, unnecessary_import

import 'package:final_project_advanced_mobile/feature/auth/provider/authenticate_provider.dart';
import 'package:final_project_advanced_mobile/feature/dashboard/views/post_a_project/views/project_post_2.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './project_details.dart';
import './saved_projects.dart';
import './filter_modal.dart';
import './apply_project.dart';
import '../provider/project_provider.dart';
import '../constants/projetcs_type.dart';
import '../utils/convert_days.dart';

class ProjectPage extends StatefulWidget {
  ProjectPage({super.key});

  @override
  State<ProjectPage> createState() => _ProjectPageState();
}

class _ProjectPageState extends State<ProjectPage> {
  @override
  Widget build(BuildContext context) {
    final projectProvider = Provider.of<ProjectProvider>(context);
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
                          controller: projectProvider.searchController,
                          onChanged: (value) {
                            projectProvider.updateSearch();
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
                          icon: Icon(
                              projectProvider.searchController.text.isNotEmpty
                                  ? Icons.filter_list
                                  : Icons.favorite),
                          onPressed: () {
                            projectProvider.searchController.text.isNotEmpty
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
                                        builder: (context) =>
                                            SavedProjectWidget()),
                                  );
                          }),
                    ],
                  )),
              Expanded(
                child: FutureBuilder(
                  future: context.watch<ProjectProvider>().getAllProjectForStudent(
                    studentId: context.read<AuthenticateProvider>().authenRepository.student?['id'],
                    token: context.read<AuthenticateProvider>().authenRepository.token!),
                  builder:(context, snapshot) => ListView.builder(
                    itemCount: snapshot.data?.result?.length ?? 0,
                    itemBuilder: (context, index) {
                      // final project = projectProvider.projects[index];
                      final project = Project.fromJson(snapshot.data?.result?[index]);
                      bool disableFlag = true;
                      final favouriteProjectList = context.read<ProjectProvider>().favouriteProjectList;

                      favouriteProjectList?.forEach(
                        (element) {
                          
                          if(project.id == element['project']['id']){
                        
                            disableFlag = false;
                          }
                        },
                      );
                      print(disableFlag);
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
                                          onPressed: () async{
                                            setState(() {
                                              
                                            }); 
                                            await context.read<ProjectProvider>().toggleFavoriteStatus(
                                              token: context.read<AuthenticateProvider>().authenRepository.token!,
                                              studentId:context.read<AuthenticateProvider>().authenRepository.student?['id'], 
                                              projectId: project.id!,
                                              disableFlag: disableFlag);
                                            // Gọi hàm toggleFavoriteStatus với chỉ số index
                                          },
                                          icon: Icon(
                                            disableFlag
                                                ?  // Nếu true, hiển thị biểu tượng favorite đã được tô màu
                                                Icons
                                                    .favorite_border:Icons
                                                    .favorite, // Nếu false, hiển thị biểu tượng favorite_border không thay đổi màu sắc
                                            color: disableFlag
                                                ? Colors.red
                                                : null, // Thay đổi màu biểu tượng thành màu trắng nếu là favorite, nếu không thì để mặc định
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
                                    'Time: ${optionsTimeForJob[project.time]!}',
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
                                          Text(project.describe!)
                                              
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
                                      TextButton(
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ApplyProject()),
                                          );
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
              ),
            ],
          ),
        );
  }
}
