import 'package:final_project_advanced_mobile/constants/colors.dart';
import 'package:final_project_advanced_mobile/feature/dashboard/views/post_a_project/models/job_model.dart';
import 'package:final_project_advanced_mobile/feature/dashboard/views/post_a_project/views/project_post_3.dart';
import 'package:final_project_advanced_mobile/languages/language.dart';
import 'package:final_project_advanced_mobile/widgets/basic_page.dart';
import 'package:final_project_advanced_mobile/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

class ProjectPost_2 extends StatelessWidget {
  int? currentOption = 0;
  @override
  Widget build(BuildContext context) {
    JobModel.timeForProjectController.text = currentOption.toString();
    // TODO: implement build
    return BasicPage(
        child: Container(
      color: Get.isDarkMode ? Themes.backgroundDark : Themes.backgroundLight,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text("2/4"),
                SizedBox(
                  width: 10,
                ),
                Text(Languages.of(context)!.letStart2)
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Text(Languages.of(context)!.postDescription2),
            SizedBox(
              height: 20,
            ),
            Text(Languages.of(context)!.questionProjectTake),
            SizedBox(
              height: 10,
            ),
            TimeForProject(
                timeForProjectController: JobModel.timeForProjectController,
                currentOption: currentOption!),
            SizedBox(
              height: 10,
            ),
            Text(Languages.of(context)!.questionStudentNeed),
            SizedBox(
              height: 10,
            ),
            CustomTextField(
                onChanged: (p0) {},
                controller: JobModel.numberStudentController,
                hintText: Languages.of(context)!.studentNeed),
            SizedBox(
              height: 10,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 0.5,
                ),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) {
                      return ProjectPost_3();
                    },
                  ));
                },
                child: Text(Languages.of(context)!.next),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}

class TimeForProject extends StatefulWidget {
  TimeForProject(
      {super.key,
      required this.currentOption,
      required this.timeForProjectController});

  int currentOption;
  TextEditingController timeForProjectController = TextEditingController();
  @override
  State<TimeForProject> createState() => _TimeForProjectState();
}

class _TimeForProjectState extends State<TimeForProject> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text(Languages.of(context)!.timeTake1),
          leading: Radio(
            value: 0,
            groupValue: widget.currentOption,
            onChanged: (value) {
              setState(() {
                widget.timeForProjectController.text = value.toString();
                widget.currentOption = value!;
              });
            },
          ),
        ),
        ListTile(
          title: Text(Languages.of(context)!.timeTake2),
          leading: Radio(
            value: 1,
            groupValue: widget.currentOption,
            onChanged: (value) {
              setState(() {
                widget.timeForProjectController.text = value.toString();
                widget.currentOption = value!;
              });
            },
          ),
        ),
        ListTile(
          title: Text(Languages.of(context)!.timeTake3),
          leading: Radio(
            value: 2,
            groupValue: widget.currentOption,
            onChanged: (value) {
              setState(() {
                widget.timeForProjectController.text = value.toString();
                widget.currentOption = value!;
              });
            },
          ),
        ),
        ListTile(
          title: Text(Languages.of(context)!.timeTake4),
          leading: Radio(
            value: 3,
            groupValue: widget.currentOption,
            onChanged: (value) {
              setState(() {
                widget.timeForProjectController.text = value.toString();
                widget.currentOption = value!;
              });
            },
          ),
        ),
      ],
    );
  }
}
