import 'package:final_project_advanced_mobile/constants/status_flag.dart';
import 'package:final_project_advanced_mobile/constants/type_flag.dart';
import 'package:final_project_advanced_mobile/feature/auth/provider/authenticate_provider.dart';
import 'package:final_project_advanced_mobile/feature/chat/provider/chat_provider.dart';
import 'package:final_project_advanced_mobile/feature/chat/views/chat_message.dart';
import 'package:final_project_advanced_mobile/feature/dashboard/views/manage_project/models/student_models.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


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
    proposals = proposals.where((element) => element['statusFlag'].toString() == statusFlag['Waiting'].toString(),).toList();
    return Container(
      child: ListView.builder(
        itemCount: proposals.length,
        itemBuilder: (context, index) {
          final proposal = proposals[index];
          final date = DateTime.parse(proposal['createdAt'].toString());
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
                            Text('${proposal['student']['user']['fullname']}',style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold
                            ),),
                            Text('${date.day}-${date.month}-${date.year}',style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.normal
                            ),),
                          ],

                        ))
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(proposal['student']['techStack']['name'],style: Theme.of(context).textTheme.bodyLarge?.copyWith(
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
                        onPressed: (){
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => 
                          ChatScreen(
                            projectId: proposal['projectId'], 
                            receiveId: proposal['student']['userId'], 
                            nameReceiver:proposal['student']['user']['fullname'],
                            proposalId: proposal['id'],
                            
                            ),));
                        },
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
                                ElevatedButton(onPressed: ()async{
                                  await context.read<ChatProvider>().updateStatusOfStudetnProposal(
                                    proposalId: proposal['id'], 
                                    token: context.read<AuthenticateProvider>().authenRepository.token!,
                                    statusFlag: statusFlag['Offer']!);
                                  Navigator.of(context).pop();
                                }, child: Text("Send")),
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
