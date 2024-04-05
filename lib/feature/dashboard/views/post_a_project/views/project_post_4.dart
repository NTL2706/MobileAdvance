import 'package:final_project_advanced_mobile/feature/auth/provider/authenticate_provider.dart';
import 'package:final_project_advanced_mobile/feature/dashboard/providers/JobNotifier.dart';
import 'package:final_project_advanced_mobile/feature/dashboard/views/post_a_project/models/job_model.dart';
import 'package:final_project_advanced_mobile/feature/home/views/home_page.dart';
import 'package:final_project_advanced_mobile/widgets/basic_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/quickalert.dart';

class ProjectPost_4 extends StatelessWidget {
  const ProjectPost_4({super.key});

  @override
  Widget build(BuildContext context) {

    return BasicPage(
      child: Container(
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
                    decoration: BoxDecoration(color: Colors.white, boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.5),
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
                                child: Text("Discription",
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
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Project scope",
                                  style: TextStyle(fontSize: 18),
                                ),
                                Text(
                                    "•${JobModel.timeForProjectController.text}")
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
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Student required",
                                  style: TextStyle(fontSize: 18),
                                ),
                                Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                        "•${JobModel.numberStudentController.text}"))
                              ],
                            )
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Expanded(
                          child: Align(
                              alignment: Alignment.bottomCenter,
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      elevation: 0.5,
                                      backgroundColor: Colors.white),
                                  onPressed: () async{
              

                                    final response =await context.read<JobNotifier>().addJob(
                                      companyId: context.read<AuthenticateProvider>().authenRepository.company?['id'].toString(),
                                      title: JobModel.titleController.text,
                                      projectScopeFlag: int.parse(JobModel.timeForProjectController.text),
                                      description: JobModel.discriptionController.text, 
                                      numberOfStudents: int.parse(JobModel.numberStudentController.text));
                                    if (response['result']!= null){
                                      await QuickAlert.show(
                                        context: context, 
                                        title: "Add Job",
                                        cancelBtnText: "Cancel",
                                        showCancelBtn: true,
                                        confirmBtnText: "OK",
                                        onConfirmBtnTap: () {
                                          
                                          Navigator.of(context).popUntil(ModalRoute.withName('/intro'));
                                        },
                                        onCancelBtnTap: () {
                                          Navigator.of(context).pop();
                                        },
                                        type: QuickAlertType.success
                                      );
                                    }
                                    else{
                                      await QuickAlert.show(
                                        title: "Add Job",
                                        context: context, 
                                        text: response['error'],
                                        cancelBtnText: "Cancel",
                                        showCancelBtn: true,
                                        confirmBtnText: "OK",
                                        onConfirmBtnTap: () {
                                          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => HomePage(),),(route) => false,);
                                        },
                                        onCancelBtnTap: () {
                                          Navigator.of(context).pop();
                                        },
                                        type: QuickAlertType.success
                                      );
                                    }
                                    
                                  },
                              child: Text("Post job"))),
                        )
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