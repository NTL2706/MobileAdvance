import 'package:final_project_advanced_mobile/feature/dashboard/views/post_a_project/models/job_model.dart';
import 'package:final_project_advanced_mobile/feature/dashboard/views/post_a_project/views/project_post_2.dart';
import 'package:final_project_advanced_mobile/widgets/basic_page.dart';
import 'package:final_project_advanced_mobile/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';

class ProjectPost_1 extends StatelessWidget {
  const ProjectPost_1({super.key});

  @override
  Widget build(BuildContext context) {
    JobModel.titleController.clear();
    JobModel.discriptionController.clear();
    JobModel.timeForProjectController.clear();
    JobModel.numberStudentController.clear();
    return BasicPage(
      child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text("1/4"),
                  SizedBox(
                    width: 10,
                  ),
                  Text("Let's start with a strong title")
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                  "This helps your post stand out to the right students. It's the first thing they'll see, so make it Impressive!"),
              SizedBox(
                height: 20,
              ),
              CustomTextField(
                  controller: JobModel.titleController,
                  hintText: "write a title for jour post"),
              SizedBox(
                height: 20,
              ),
              Text("Example titles"),
              Container(
                margin: EdgeInsets.only(left: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        "Build responsive WordPress site with booking payment functionality"),
                    Text("Facebook ad specialist need for product launch"),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          elevation: 1, backgroundColor: Colors.white),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) {
                            return ProjectPost_2();
                          },
                        ));
                      },
                      child: Text("Next: Scope")))
            ],
          )),
    );
  }
}
