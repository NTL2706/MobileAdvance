import 'package:final_project_advanced_mobile/feature/dashboard/constants/time_for_job.dart';
import 'package:final_project_advanced_mobile/feature/dashboard/views/post_a_project/models/job_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ManageProjectDetail extends StatelessWidget{
  ManageProjectDetail({
    super.key,
    required this.job
  });
  JobModel job;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    print((job.description));
    return Container(
      child: Column(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Text("Student are looking for:", style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold
                ),)),
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Container(
                      child: Icon(Icons.details_outlined),
                    )),
                  Expanded(
                    flex: 7,
                    child: Container(
                    child: Text("${job.description}"),
                              ),
                  ),
                ],
              ),
            ],
          ),
          
          Divider(),
          Container(
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Icon(Icons.access_time_sharp)),
                Expanded(
                  flex: 7,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Project scope",style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold
                )),
                      Text("\t${optionsTimeForJob[job.projectScopeFlag]}")
                    ],
                  ))
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Icon(Icons.person)),
                Expanded(
                  flex: 7,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Student required",style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold
                )),
                      Text("${job.numberOfStudents}")
                    ],
                  ))
              ],
            ),
          ),
        ],
      ),
    );
  }

}