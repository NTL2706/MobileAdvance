import 'package:final_project_advanced_mobile/feature/dashboard/views/post_a_project/models/job_model.dart';
import 'package:final_project_advanced_mobile/feature/dashboard/views/post_a_project/views/project_post_4.dart';
import 'package:final_project_advanced_mobile/widgets/basic_page.dart';
import 'package:flutter/material.dart';

class ProjectPost_3 extends StatelessWidget {
  const ProjectPost_3({super.key});

  @override
  Widget build(BuildContext context) {
    return BasicPage(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text("3/4"),
                  SizedBox(
                    width: 10,
                  ),
                  Text("Next, provide project discription")
                ],
              ),
              Text("Student are looking for"),
              Container(
                margin: EdgeInsets.only(left: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        "Clear expectation about your project or deliverables"),
                    Text("The skills required for your project"),
                    Text("Detall about your project"),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                controller: JobModel.discriptionController,
                maxLines: 8,
                decoration: InputDecoration(
                  focusedBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      borderSide: BorderSide(
                          color: Colors.black, style: BorderStyle.solid)),
                  border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Expanded(
                child: Align(
                alignment: Alignment.topRight,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                  elevation: 0.5,
                  backgroundColor: Colors.white
                ),
                  onPressed: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                    return ProjectPost_4();
                  },));
                }, child: Text("Review your post"))),
              )
            ],
          ),
        ),
      ),
    );
  }
}
