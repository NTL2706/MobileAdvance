import 'package:final_project_advanced_mobile/constants/colors.dart';
import 'package:final_project_advanced_mobile/feature/auth/provider/authenticate_provider.dart';
import 'package:final_project_advanced_mobile/feature/dashboard/constants/time_for_job.dart';
import 'package:final_project_advanced_mobile/feature/dashboard/providers/JobNotifier.dart';
import 'package:final_project_advanced_mobile/feature/dashboard/views/post_a_project/models/job_model.dart';
import 'package:final_project_advanced_mobile/feature/home/views/home_page.dart';
import 'package:final_project_advanced_mobile/languages/language.dart';
import 'package:final_project_advanced_mobile/widgets/basic_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/quickalert.dart';

class ProjectPost_4 extends StatelessWidget {
  const ProjectPost_4({super.key});

  @override
  Widget build(BuildContext context) {
    return BasicPage(
      child: Container(
        color: Get.isDarkMode ? Themes.backgroundDark : Themes.backgroundLight,
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Stack(
              children: [
                Positioned(
                    top: 0,
                    child: Container(
                      decoration: BoxDecoration(color: Color(0xFFA0D44E)),
                      height: constraints.maxHeight * 0.2,
                      width: constraints.maxWidth,
                    )),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Get.isDarkMode
                            ? Themes.boxDecorationDark
                            : Themes.boxDecorationLight,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            // color: Colors.black.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3),
                          )
                        ]),
                    width: constraints.maxWidth * 0.8,
                    height: constraints.maxHeight * 0.7,
                    child: Column(
                      children: [
                        const CircleAvatar(
                          backgroundImage: AssetImage("assets/images/logo.png"),
                          radius: 50,
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            "${JobModel.titleController.text}",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Divider(
                          thickness: 0.5,
                        ),
                        Container(
                          width: constraints.maxWidth,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Align(
                                alignment: Alignment.center,
                                child: Text(Languages.of(context)!.description,
                                    style: TextStyle(fontSize: 18)),
                              ),
                              Text("${JobModel.discriptionController.text}")
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Divider(
                          thickness: 0.5,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Icon(Icons.timer_sharp),
                            SizedBox(
                              width: 5,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  Languages.of(context)!.time,
                                  style: TextStyle(fontSize: 18),
                                ),
                                Text(
                                    "•  ${optionsTimeForJob[int.parse(JobModel.timeForProjectController.text)]}")
                              ],
                            )
                          ],
                        ),
                        Divider(
                          thickness: 0.5,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Icon(Icons.person_outline),
                            SizedBox(
                              width: 5,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  Languages.of(context)!.studentNeed,
                                  style: TextStyle(fontSize: 18),
                                ),
                                Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                        "•  ${JobModel.numberStudentController.text}"))
                              ],
                            )
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Align(
                            alignment: Alignment.bottomCenter,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  elevation: 0.5,
                                ),
                                onPressed: () async {
                                  final response = await context
                                      .read<JobNotifier>()
                                      .addJob(
                                          token:
                                              context
                                                  .read<AuthenticateProvider>()
                                                  .authenRepository
                                                  .token!,
                                          companyId:
                                              context
                                                  .read<AuthenticateProvider>()
                                                  .authenRepository
                                                  .company?['id']
                                                  .toString(),
                                          title: JobModel.titleController.text,
                                          projectScopeFlag: int.parse(JobModel
                                              .timeForProjectController.text),
                                          description: JobModel
                                              .discriptionController.text,
                                          numberOfStudents: int.parse(JobModel
                                              .numberStudentController.text));
                                  if (response['result'] != null) {
                                    await QuickAlert.show(
                                        context: context,
                                        title: Languages.of(context)!.addJob,
                                        cancelBtnText:
                                            Languages.of(context)!.cancel,
                                        showCancelBtn: true,
                                        confirmBtnText:
                                            Languages.of(context)!.oke,
                                        onConfirmBtnTap: () {
                                          Navigator.of(context)
                                              .pushAndRemoveUntil(
                                                  MaterialPageRoute(
                                            builder: (context) {
                                              return HomePage();
                                            },
                                          ), (route) => false);
                                        },
                                        onCancelBtnTap: () {
                                          Navigator.of(context).pop();
                                        },
                                        type: QuickAlertType.success);
                                    JobModel.titleController.clear();
                                    JobModel.discriptionController.clear();
                                    JobModel.timeForProjectController.clear();
                                    JobModel.numberStudentController.clear();
                                  } else {
                                    await QuickAlert.show(
                                        title: Languages.of(context)!.addJob,
                                        context: context,
                                        text: response['error'],
                                        cancelBtnText:
                                            Languages.of(context)!.cancel,
                                        showCancelBtn: true,
                                        confirmBtnText:
                                            Languages.of(context)!.oke,
                                        onConfirmBtnTap: () {
                                          Navigator.of(context).popUntil(
                                              ModalRoute.withName('/home'));
                                        },
                                        onCancelBtnTap: () {
                                          Navigator.of(context).pop();
                                        },
                                        type: QuickAlertType.success);
                                  }
                                },
                                child: Text(Languages.of(context)!.postJob))),
                      ],
                    ),
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}

// Container(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//                 children: [
//                   Text("4/4"),
//                   SizedBox(width: 10,),
//                   Text("Project details", style: TextStyle(
//                     fontSize: 20,
//                     fontWeight: FontWeight.bold
//                   ),)
//                 ],
//               ),
//             Text("${JobModel.titleController.text}", style: TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold
//             ),),

//             Container(
//               child: Text("${JobModel.discriptionController.text}"),
//             ),
//             Row(
//               children: [
//                 Icon(Icons.timer_sharp),
//                 Column(
//                   children: [
//                     Text("Project scope"),
//                     Text("${JobModel.timeForProjectController.text}")
//                   ],
//                 )
//               ],
//             ),
//             Row(
//               children: [
//                 Icon(Icons.person_outline),
//                 Column(
//                   children: [
//                     Text("Student required"),
//                     Text("${JobModel.numberStudentController.text}")
//                   ],
//                 )
//               ],
//             ),
            
//           ],
//         ),
//       ),