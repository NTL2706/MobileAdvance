// ignore_for_file: prefer_const_constructors

import 'package:final_project_advanced_mobile/feature/auth/provider/authenticate_provider.dart';
import 'package:final_project_advanced_mobile/feature/projects/constants/projetcs_type.dart';
import 'package:final_project_advanced_mobile/feature/projects/provider/project_provider.dart';
import 'package:final_project_advanced_mobile/languages/language.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ApplyProject extends StatelessWidget {
  TextEditingController coverLetterTextController = TextEditingController();
  ApplyProject({super.key, required this.disableFlag, required this.project});
  Project project;
  bool disableFlag;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Languages.of(context)!.applyProject),
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                Languages.of(context)!.applyText,
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10.0),
              Text(
                Languages.of(context)!.descriptionText,
                style: TextStyle(fontSize: 16.0),
              ),
              SizedBox(height: 20.0),
              Expanded(
                child: TextField(
                  controller: coverLetterTextController,
                  maxLines: 5, // Allow for multiple lines
                  decoration: InputDecoration(
                    hintText: 'Enter your text here...',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(Languages.of(context)!.cancel),
                  ),
                  SizedBox(width: 20.0),
                  ElevatedButton(
                    onPressed: () async {
                      // Add your button 2 action here
                      await context.read<ProjectProvider>().applyProposal(
                          token: context
                              .read<AuthenticateProvider>()
                              .authenRepository
                              .token!,
                          projectId: project.id!,
                          studentId: context
                              .read<AuthenticateProvider>()
                              .authenRepository
                              .student?['id'],
                          coverLetter: coverLetterTextController.text,
                          );
                      final rs = context.read<ProjectProvider>().responseHttp;

                      if (rs.result != null) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          backgroundColor: Colors.green,
                          content: Text(
                            Languages.of(context)!.sendedSuccess,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(color: Colors.black),
                          ),
                        ));
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          backgroundColor: Colors.red,
                          content: Text(
                            Languages.of(context)!.sendedFail,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(color: Colors.white),
                          ),
                        ));
                      }
                    },
                    child: Text(Languages.of(context)!.apply),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
