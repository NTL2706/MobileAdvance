import 'package:final_project_advanced_mobile/feature/dashboard/providers/JobNotifier.dart';
import 'package:final_project_advanced_mobile/feature/dashboard/views/manage_project/views/manage_project.dart';
import 'package:final_project_advanced_mobile/feature/dashboard/views/post_a_project/models/job_model.dart';
import 'package:final_project_advanced_mobile/feature/dashboard/views/post_a_project/views/project_post_1.dart';
import 'package:final_project_advanced_mobile/widgets/tab_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

// List<JobModel> jobList = [
//   JobModel(
//     HiredNumber: 0,
//     createAt: "Create 3 days ago",
//     discription: "Clear expectation about your project or deliverables",
//     messagesNumber: 8,
//     numberStudent: 0,
//     proposalNumber: 2,
//     title: "Senior frontend developer (Fintech)",
//   ),
//   JobModel(
//     HiredNumber: 0,
//     createAt: "Create 3 days ago",
//     discription: "Clear expectation about your project or deliverables",
//     messagesNumber: 8,
//     numberStudent: 0,
//     proposalNumber: 2,
//     title: "Senior frontend developer (Fintech)",
//   ),
//   JobModel(
//     HiredNumber: 0,
//     createAt: "Create 3 days ago",
//     discription: "Clear expectation about your project or deliverables",
//     messagesNumber: 8,
//     numberStudent: 0,
//     proposalNumber: 2,
//     title: "Senior frontend developer (Fintech)",
//   ),
//   JobModel(
//     HiredNumber: 0,
//     createAt: "Create 3 days ago",
//     discription: "Clear expectation about your project or deliverables",
//     messagesNumber: 8,
//     numberStudent: 0,
//     proposalNumber: 2,
//     title: "Senior frontend developer (Fintech)",
//   ),
//   JobModel(
//     HiredNumber: 0,
//     createAt: "Create 3 days ago",
//     discription: "Clear expectation about your project or deliverables",
//     messagesNumber: 8,
//     numberStudent: 0,
//     proposalNumber: 2,
//     title: "Senior frontend developer (Fintech)",
//   ),
//   JobModel(
//     HiredNumber: 0,
//     createAt: "Create 3 days ago",
//     discription: "Clear expectation about your project or deliverables",
//     messagesNumber: 8,
//     numberStudent: 0,
//     proposalNumber: 2,
//     title: "Senior frontend developer (Fintech)",
//   ),
//   JobModel(
//     HiredNumber: 0,
//     createAt: "Create 3 days ago",
//     discription: "Clear expectation about your project or deliverables",
//     messagesNumber: 8,
//     numberStudent: 0,
//     proposalNumber: 2,
//     title: "Senior frontend developer (Fintech)",
//   ),
//   JobModel(
//     HiredNumber: 0,
//     createAt: "Create 3 days ago",
//     discription: "Clear expectation about your project or deliverables",
//     messagesNumber: 8,
//     numberStudent: 0,
//     proposalNumber: 2,
//     title: "Senior frontend developer (Fintech)",
//   ),
// ];

class DashBoard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      decoration: BoxDecoration(color: Colors.white),
      child: Padding(
        padding: const EdgeInsets.all(0),
        child: Container(
          child: Column(
            children: [
              Container(
                height: 50,
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(color: Colors.blue),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Your projects",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white)),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          elevation: 0.2,
                          minimumSize: Size(30, 30),
                        ),
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return ProjectPost_1();
                            },
                          ));
                        },
                        child: Text(
                          "Post a jobs",
                          style: TextStyle(color: Colors.black),
                        ))
                  ],
                ),
              ),
              Expanded(
                  child: Container(
                child: CustomTabBar(
                  lengOfTabBar: 3,
                  tabs: [
                    Text("All projects"),
                    Text("Working"),
                    Text("Archieve"),
                  ],
                  tab_views: [
                    AllProjectWidget(
                      state: JobState.pending.name,
                    ),
                    AllProjectWidget(
                      state: JobState.working.name,
                    ),
                    AllProjectWidget(
                      state: JobState.archieved.name,
                    ),
                  ],
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }
}

class AllProjectWidget extends StatelessWidget {
  AllProjectWidget(
    {
      super.key,
      required this.state 
    });
  String? state;
  @override
  Widget build(BuildContext context) {
    List<JobModel> jobList = context.watch<JobNotifier>().jobList;
    jobList = jobList.where((element){
      return element.state == state;
    },).toList();

  
    return Container(
      child: ListView.builder(
        itemCount: jobList.length,
        itemBuilder: (context, index) {
          JobModel job = jobList[index];
          return GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) {
                  return ManageProject();
                },
              ));
            },
            child: Container(
              margin: EdgeInsets.only(top: 5),
              height: 165,
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                color: Colors.grey.shade200,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(job.title!,
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(fontWeight: FontWeight.bold)),
                      SizedBox(
                          height: 30,
                          child: PopupMenuButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)
                            ),
                            color: Colors.white,
                            itemBuilder: (context) {
                              return [
                                PopupMenuItem(
                                  onTap: (){},
                                  child: Text("View proposals")
                                ),
                                PopupMenuItem(
                                  onTap: (){},
                                  child: Text("View messages")
                                ),
                                PopupMenuItem(
                                  onTap: (){},
                                  child: Text("View hired")
                                ),
                                PopupMenuItem(
                                  onTap: (){},
                                  child: Text("View job posting")
                                ),
                                PopupMenuItem(
                                  onTap: (){},
                                  child: Text("Edit posting")
                                ),
                                PopupMenuItem(
                                  onTap: (){
                                    context.read<JobNotifier>().deleteJob(id:job.id!);
                                  },
                                  child: Text("Remove posting")
                                ),
                                PopupMenuItem(
                                  onTap: (){
                                    context.read<JobNotifier>().updateJob(id: job.id!, state: JobState.working.name);
                                  },
                                  child: Text("Start working")
                                ),
                              ];
                            }, 
                          ) 
                        )
                    ],
                  ),
                  Text(job.createAt!),
                  Text("Student are looking for"),
                  Text("${"-\r${job.discription}"}"),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Container(
                          alignment: Alignment.center,
                          child: Column(
                            children: [
                              Container(
                                  alignment: Alignment.center,
                                  height: 25,
                                  width: 20,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(color: Colors.black)),
                                  child: Text("${job.proposalNumber}")),
                              Text("Proposals")
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          alignment: Alignment.center,
                          child: Column(
                            children: [
                              Container(
                                  alignment: Alignment.center,
                                  height: 25,
                                  width: 20,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(color: Colors.black)),
                                  child: Text("${job.messagesNumber}")),
                              Text("Messages")
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          alignment: Alignment.center,
                          child: Column(
                            children: [
                              Container(
                                  alignment: Alignment.center,
                                  height: 25,
                                  width: 20,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(color: Colors.black)),
                                  child: Text("${job.HiredNumber}")),
                              Text("Hired")
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}


