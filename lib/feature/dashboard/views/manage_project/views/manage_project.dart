import 'package:final_project_advanced_mobile/constants/colors.dart';
import 'package:final_project_advanced_mobile/feature/dashboard/views/manage_project/views/manage_project_detail.dart';
import 'package:final_project_advanced_mobile/feature/dashboard/views/manage_project/views/manage_project_hired.dart';
import 'package:final_project_advanced_mobile/feature/dashboard/views/manage_project/views/manage_project_proposal.dart';
import 'package:final_project_advanced_mobile/feature/dashboard/views/post_a_project/models/job_model.dart';
import 'package:final_project_advanced_mobile/languages/language.dart';
import 'package:final_project_advanced_mobile/widgets/basic_page.dart';
import 'package:final_project_advanced_mobile/widgets/tab_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

class ManageProject extends StatelessWidget {
  ManageProject(
      {super.key,
      required this.proposals,
      required this.job,
      this.selectIndex});
  List<Map<String, dynamic>> proposals;
  JobModel job;
  int? selectIndex;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BasicPage(
      child: Container(
        color: Get.isDarkMode ? Themes.backgroundDark : Themes.backgroundLight,
        child: Column(
          children: [
            Expanded(
              child: CustomTabBar(
                selectIndex: selectIndex,
                lengOfTabBar: 4,
                tabs: [
                  Text(
                    Languages.of(context)!.proposal,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    Languages.of(context)!.details,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    Languages.of(context)!.message,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    Languages.of(context)!.hired,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                ],
                tab_views: [
                  ManageProjectProposal(
                    proposals: proposals,
                  ),
                  ManageProjectDetail(job: job),
                  Container(
                      child: Center(
                    child: Text(Languages.of(context)!.message),
                  )),
                  ManageProjectHired(proposals: proposals)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
