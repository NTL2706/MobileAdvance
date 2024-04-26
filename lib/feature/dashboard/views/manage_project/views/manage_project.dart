import 'package:final_project_advanced_mobile/feature/dashboard/views/manage_project/views/manage_project_detail.dart';
import 'package:final_project_advanced_mobile/feature/dashboard/views/manage_project/views/manage_project_proposal.dart';
import 'package:final_project_advanced_mobile/feature/dashboard/views/post_a_project/models/job_model.dart';
import 'package:final_project_advanced_mobile/widgets/basic_page.dart';
import 'package:final_project_advanced_mobile/widgets/tab_bar.dart';
import 'package:flutter/material.dart';

class ManageProject extends StatelessWidget{
  ManageProject(
  {
    super.key,
    required this.proposals,
    required this.job
  });
  List<Map<String,dynamic>> proposals;
  JobModel job;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BasicPage(
      child: Container(
        child: Column(
          children: [
            Expanded(
              child: CustomTabBar(
                lengOfTabBar: 4,
                tabs: [
                  Text("Proposals",style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.bold
                  ),),
                  Text("Detail",style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.bold
                  ),),
                  Text("Message",style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.bold
                  ),),
                  Text("Hired",style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.bold
                  ),),
                ],
                 tab_views: [
                  ManageProjectProposal(
                    proposals: proposals,
                  ),
                  ManageProjectDetail(job: job),
                  Container(child: Center(child: Text("Message"),)),
                  Container(child: Center(child: Text("Hired"),)),
                ],
              ),
            ),
          ],
        ),
      ),
    ) ;
  }
}