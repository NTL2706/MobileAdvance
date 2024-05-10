import 'package:final_project_advanced_mobile/constants/colors.dart';
import 'package:final_project_advanced_mobile/feature/dashboard/views/post_a_project/models/job_model.dart';
import 'package:final_project_advanced_mobile/feature/dashboard/views/post_a_project/views/project_post_4.dart';
import 'package:final_project_advanced_mobile/languages/language.dart';
import 'package:final_project_advanced_mobile/widgets/basic_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

class ProjectPost_3 extends StatelessWidget {
  const ProjectPost_3({super.key});

  @override
  Widget build(BuildContext context) {
    return BasicPage(
      child: Container(
        color: Get.isDarkMode ? Themes.backgroundDark : Themes.backgroundLight,
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
                    Text(Languages.of(context)!.letStart3),
                  ],
                ),
                Text(Languages.of(context)!.postDescription2),
                Container(
                  margin: EdgeInsets.only(left: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(Languages.of(context)!.example3),
                      Text(Languages.of(context)!.example4),
                      Text(Languages.of(context)!.example5),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: JobModel.discriptionController,
                  onChanged: (value) => {
                    print(
                        "${Languages.of(context)!.noChange} ${JobModel.discriptionController.text.length}"),
                    if (JobModel.discriptionController.text.length >= 250)
                      {
                        JobModel.discriptionController.text = JobModel
                            .discriptionController.text
                            .substring(0, 270)
                      }
                  },
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
                          style: ElevatedButton.styleFrom(elevation: 0.5),
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) {
                                return ProjectPost_4();
                              },
                            ));
                          },
                          child: Text(Languages.of(context)!.review))),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
