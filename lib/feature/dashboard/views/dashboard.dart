import 'package:final_project_advanced_mobile/feature/dashboard/views/post_a_project/models/job_model.dart';
import 'package:final_project_advanced_mobile/feature/dashboard/views/post_a_project/views/project_post_1.dart';
import 'package:final_project_advanced_mobile/widgets/tab_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

List<JobModel> jobList = [
  JobModel(
    HiredNumber: 0,
    createAt: "Create 3 days ago",
    discription: "Clear expectation about your project or deliverables",
    messagesNumber: 8,
    numberStudent: 0,
    proposalNumber: 2 ,
    title: "Senior frontend developer (Fintech)",
  ),
  JobModel(
    HiredNumber: 0,
    createAt: "Create 3 days ago",
    discription: "Clear expectation about your project or deliverables",
    messagesNumber: 8,
    numberStudent: 0,
    proposalNumber: 2 ,
    title: "Senior frontend developer (Fintech)",
  ),
  JobModel(
    HiredNumber: 0,
    createAt: "Create 3 days ago",
    discription: "Clear expectation about your project or deliverables",
    messagesNumber: 8,
    numberStudent: 0,
    proposalNumber: 2 ,
    title: "Senior frontend developer (Fintech)",
  ),
  JobModel(
    HiredNumber: 0,
    createAt: "Create 3 days ago",
    discription: "Clear expectation about your project or deliverables",
    messagesNumber: 8,
    numberStudent: 0,
    proposalNumber: 2 ,
    title: "Senior frontend developer (Fintech)",
  ),
  JobModel(
    HiredNumber: 0,
    createAt: "Create 3 days ago",
    discription: "Clear expectation about your project or deliverables",
    messagesNumber: 8,
    numberStudent: 0,
    proposalNumber: 2 ,
    title: "Senior frontend developer (Fintech)",
  ),
  JobModel(
    HiredNumber: 0,
    createAt: "Create 3 days ago",
    discription: "Clear expectation about your project or deliverables",
    messagesNumber: 8,
    numberStudent: 0,
    proposalNumber: 2 ,
    title: "Senior frontend developer (Fintech)",
  ),
  JobModel(
    HiredNumber: 0,
    createAt: "Create 3 days ago",
    discription: "Clear expectation about your project or deliverables",
    messagesNumber: 8,
    numberStudent: 0,
    proposalNumber: 2 ,
    title: "Senior frontend developer (Fintech)",
  ),
  JobModel(
    HiredNumber: 0,
    createAt: "Create 3 days ago",
    discription: "Clear expectation about your project or deliverables",
    messagesNumber: 8,
    numberStudent: 0,
    proposalNumber: 2 ,
    title: "Senior frontend developer (Fintech)",
  ),
] ;
class DashBoard extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        decoration: BoxDecoration(
          color: Colors.white
        ),
        child: Padding(
          padding: const EdgeInsets.all(0),
          child: Container(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Your projects",style: TextStyle(
                      fontWeight: FontWeight.bold
                    )),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 0.5,
                        
                      ),
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) {
                          return ProjectPost_1();
                        },));
                      },
                      child: Text("Post a jobs",style: TextStyle(
                        color: Colors.black
                      ),)
                    )
                  ],
                ),
                Expanded(
                  child: Container(
                    child: CustomTabBar(
                      tabs: [
                        Text("All projects"),
                        Text("Working"),
                        Text("Archieve"),
                      ],
                      tab_views: [
                        AllProjectWidget(),
                        Text("Working"),
                        Text("Archieved Projects")
                      ],
                    ) ,
                  )
                )
              ],
            ),
          ),
        ),
      );
  }

}

class AllProjectWidget extends StatelessWidget{
  @override

  Widget build(BuildContext context) {
    return Container(
      
      child: ListView.builder(
        itemCount: jobList.length,
        itemBuilder: (context, index) {
          JobModel job = jobList[index];
          return Container(
            margin: EdgeInsets.only(top: 5),
            height: 150,
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              
              borderRadius: BorderRadius.circular(5.0),
              color: Colors.grey.shade200,
              
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(job.title!,style: Theme.of(context).textTheme.bodyLarge),
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
                            Text("${job.proposalNumber}"),
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
                            Text("${job.messagesNumber}"),
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
                              decoration: BoxDecoration(
                                shape: BoxShape.circle
                              ),
                              child: Text("${job.HiredNumber}")),
                            Text("Hired")
                          ],
                        ),
                      ),
                    ),
                 
                  ],
                )
                
              ],
            ) ,
          );
        },
      ),
    );
  }

}

// child: ListView.builder(
        //   itemCount: 1,
        //   itemBuilder: (context, index) {
        //     return Container(
        //       height: 100,
              
        //       decoration: BoxDecoration(
                
        //         borderRadius: BorderRadius.circular(5.0),
        //         color: Colors.black45,
        //         boxShadow: [
        //           BoxShadow(
        //             color: Colors.grey,
        //             offset: Offset(0.0, 1.0), //(x,y)
        //             blurRadius: 6.0,
        //           )
        //         ]
        //       ),
        //       child: Center(child: Text("hello"),) ,
        //     );
        //   },
        // ),