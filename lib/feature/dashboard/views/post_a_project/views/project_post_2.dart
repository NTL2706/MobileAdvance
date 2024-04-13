import 'package:final_project_advanced_mobile/feature/dashboard/views/post_a_project/models/job_model.dart';
import 'package:final_project_advanced_mobile/feature/dashboard/views/post_a_project/views/project_post_3.dart';
import 'package:final_project_advanced_mobile/widgets/basic_page.dart';
import 'package:final_project_advanced_mobile/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';



class ProjectPost_2 extends StatelessWidget{
  int? currentOption = 0;
  @override
  Widget build(BuildContext context) {
    JobModel.timeForProjectController.text = currentOption.toString();
    // TODO: implement build
    return BasicPage(
      child: Container(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text("2/4"),
                  SizedBox(width: 10,),
                  Text("Next, estimate the scope of your job")
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Text("Consider the size of your project and the timeline"),
                            SizedBox(
                height: 20,
              ),
              Text("How long will your project take?"),
              SizedBox(
                height: 10,
              ),
              TimeForProject(
                timeForProjectController: JobModel.timeForProjectController,
                currentOption: currentOption!),
              SizedBox(
                height: 10,
              ),
              Text("How many student do you want for this project?"),
              SizedBox(
                height: 10,
              ),
              CustomTextField(
                onChanged: (p0) {
                  
                },
                controller: JobModel.numberStudentController,
                hintText: "number of students"),
              SizedBox(
                height: 10,
              ),
              Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 0.5,
                  backgroundColor: Colors.white
                ),
                onPressed: (){
                
                Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                  return ProjectPost_3();
                },));
              }, child: Text("Next: Discription")))
            ],
          ),
        ),
      )
    );
  }
  
}


class TimeForProject extends StatefulWidget {
  TimeForProject({
    super.key,
    required this.currentOption,
    required this.timeForProjectController
  });

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
          title: Text("Less than one month"),
          leading: Radio(
            value: 0,
            groupValue: widget.currentOption,
            onChanged: (value) {
              setState((){
                  widget.timeForProjectController.text = value.toString();
                  widget.currentOption = value!;
              });
            },
          ),
        ),
        ListTile(
          title: Text("1 - 3 months"),
          leading: Radio(
            value: 1,
            groupValue: widget.currentOption,
            onChanged: (value) {
              setState((){
                  widget.timeForProjectController.text = value.toString();
                  widget.currentOption = value!;
              });
            },
          ),
        ),
        ListTile(
          title: Text("3 to 6 months"),
          leading: Radio(
            value: 2,
            groupValue: widget.currentOption,
            onChanged: (value) {
              setState((){
                  widget.timeForProjectController.text = value.toString();
                  widget.currentOption = value!;
              });
            },
          ),
        ),
        ListTile(
          title: Text("more than 6 months"),
          leading: Radio(
            value: 3,
            groupValue: widget.currentOption,
            onChanged: (value) {
              setState(
                (){
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