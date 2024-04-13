import 'package:final_project_advanced_mobile/feature/dashboard/views/manage_project/models/student_models.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

List<StudentModel> studentLists = [
  StudentModel(name: "Hung", age: "4th year student", position: "Full stack"),
  StudentModel(name: "Khoi", age: "2th year student", position: "Backend"),
  StudentModel(name: "Tien", age: "3th year student", position: "Mobile"),
  StudentModel(name: "Nghia", age: "3th year student", position: "Data engineer"),
  StudentModel(name: "Khoi", age:"2th year student", position: "Data engineer"),
];

class ManageProjectProposal extends StatelessWidget {
  ManageProjectProposal(
    {
      super.key,
      required this.proposals
    });
  List<Map<String,dynamic>> proposals;
  @override
  Widget build(BuildContext context) {
    print(proposals);
    return Container(
      child: ListView.builder(
        itemCount: proposals.length,
        itemBuilder: (context, index) {
          StudentModel student = studentLists[index];
          final proposal = proposals[index];
          return Container(
            margin: EdgeInsets.only(bottom: 10),
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.grey.shade200),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    //avatar
                    Expanded(flex: 2, child: Image.asset('assets/images/avatar.png')),
                    //name and year
                    Expanded(
                        flex: 8,
                        child: Column(
                          children: [
                            Text('ID: ${proposal['id']}',style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold
                            ),),
                            // Text(student.age.toString())
                          ],
                        ))
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(student.position!,style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold
                    ),),
                    // Text("excellent")
                  ],
                ),

                Align(
                  alignment: Alignment.centerLeft,
                  child: Text("${proposal['coverLetter']}"))
                ,
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          elevation: 0.5,
                          backgroundColor: Colors.white
                        ),
                        child:Text("Message",style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                   
                        ),),
                        onPressed: (){},
                    )),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          elevation: 0.5,
                          backgroundColor: Colors.white
                        ),
                      child:Text("Hire",style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                   
                        )),onPressed: (){
                          showDialog(context: context, builder: (context) {
                            return AlertDialog(
                              backgroundColor: Colors.white,
                              actions: [
                                ElevatedButton(onPressed: (){
                                  Navigator.of(context).pop();
                                }, child: Text("Cancel")),
                                ElevatedButton(onPressed: (){}, child: Text("Send")),
                              ],
                              title: Text("Hired offer"),
                              content: Container(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text("Do you really want to send hired offer for student to do this project?")
                                  ],
                                ),
                              ),
                            );
                          },);
                        },))
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
