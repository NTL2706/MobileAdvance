import 'package:final_project_advanced_mobile/constants/colors.dart';
import 'package:final_project_advanced_mobile/feature/dashboard/views/post_a_project/models/job_model.dart';
import 'package:final_project_advanced_mobile/feature/dashboard/views/post_a_project/views/project_post_2.dart';
import 'package:final_project_advanced_mobile/languages/language.dart';
import 'package:final_project_advanced_mobile/widgets/basic_page.dart';
import 'package:final_project_advanced_mobile/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

class ProjectPost_1 extends StatefulWidget {
  const ProjectPost_1({super.key});

  @override
  State<ProjectPost_1> createState() => _ProjectPost_1State();
}

class _ProjectPost_1State extends State<ProjectPost_1> {
  @override
  Widget build(BuildContext context) {
    return BasicPage(
      child: Container(
          color:
              Get.isDarkMode ? Themes.backgroundDark : Themes.backgroundLight,
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
                  Text(Languages.of(context)!.letStart),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Text(Languages.of(context)!.postJobDescription),
              SizedBox(
                height: 20,
              ),
              CustomTextField(
                onChanged: (p0) {
                  if (JobModel.titleController.text.length >= 80) {
                    JobModel.titleController.text =
                        JobModel.titleController.text.substring(0, 80);
                  }
                  setState(() {});
                },
                controller: JobModel.titleController,
                hintText: Languages.of(context)!.description,
              ),
              SizedBox(
                height: 20,
              ),
              Text(Languages.of(context)!.exampleTitle),
              Container(
                margin: EdgeInsets.only(left: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(Languages.of(context)!.example1),
                    Text(Languages.of(context)!.example2),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              if (JobModel.titleController.text != "")
                Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            elevation: 1,
                            backgroundColor: Get.isDarkMode
                                ? Themes.backgroundDark
                                : Themes.backgroundLight),
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) {
                              return ProjectPost_2();
                            },
                          ));
                        },
                        child: Text(Languages.of(context)!.next)))
            ],
          )),
    );
  }
}
