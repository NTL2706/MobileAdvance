import 'package:final_project_advanced_mobile/constants/colors.dart';
import 'package:final_project_advanced_mobile/feature/dashboard/constants/time_for_job.dart';
import 'package:final_project_advanced_mobile/feature/dashboard/views/post_a_project/models/job_model.dart';
import 'package:final_project_advanced_mobile/languages/language.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

class ManageProjectDetail extends StatelessWidget {
  ManageProjectDetail({super.key, required this.job});
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
                  child: Text(
                    Languages.of(context)!.lookingFor,
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(fontWeight: FontWeight.bold),
                  )),
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
                Expanded(flex: 3, child: Icon(Icons.access_time_sharp)),
                Expanded(
                    flex: 7,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(Languages.of(context)!.time,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(fontWeight: FontWeight.bold)),
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
                Expanded(flex: 3, child: Icon(Icons.person)),
                Expanded(
                    flex: 7,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(Languages.of(context)!.studentNeed,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(fontWeight: FontWeight.bold)),
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
