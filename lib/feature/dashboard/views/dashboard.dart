import 'package:final_project_advanced_mobile/constants/colors.dart';
import 'package:final_project_advanced_mobile/constants/status_flag.dart';
import 'package:final_project_advanced_mobile/feature/auth/constants/sigup_category.dart';
import 'package:final_project_advanced_mobile/feature/auth/provider/authenticate_provider.dart';
import 'package:final_project_advanced_mobile/feature/dashboard/providers/JobNotifier.dart';
import 'package:final_project_advanced_mobile/feature/dashboard/views/manage_project/views/manage_project.dart';
import 'package:final_project_advanced_mobile/feature/dashboard/views/post_a_project/models/job_model.dart';
import 'package:final_project_advanced_mobile/feature/dashboard/views/post_a_project/views/project_post_1.dart';
import 'package:final_project_advanced_mobile/languages/language.dart';
import 'package:final_project_advanced_mobile/widgets/tab_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:provider/provider.dart';

// List<JobModel> jobList = [
//   JobModel(
//     HiredNumber: 0,
//     createAt: "Create 3 days ago",
//     discription: "Clear expectation about your project or deliverables",
//     messagesNumber: 8,
//     numberStudent: 0,
//     proposalNumber: 2,
//     title: "Senior frontend developer (Fintech)",
//   ),
//   JobModel(
//     HiredNumber: 0,
//     createAt: "Create 3 days ago",
//     discription: "Clear expectation about your project or deliverables",
//     messagesNumber: 8,
//     numberStudent: 0,
//     proposalNumber: 2,
//     title: "Senior frontend developer (Fintech)",
//   ),
//   JobModel(
//     HiredNumber: 0,
//     createAt: "Create 3 days ago",
//     discription: "Clear expectation about your project or deliverables",
//     messagesNumber: 8,
//     numberStudent: 0,
//     proposalNumber: 2,
//     title: "Senior frontend developer (Fintech)",
//   ),
//   JobModel(
//     HiredNumber: 0,
//     createAt: "Create 3 days ago",
//     discription: "Clear expectation about your project or deliverables",
//     messagesNumber: 8,
//     numberStudent: 0,
//     proposalNumber: 2,
//     title: "Senior frontend developer (Fintech)",
//   ),
//   JobModel(
//     HiredNumber: 0,
//     createAt: "Create 3 days ago",
//     discription: "Clear expectation about your project or deliverables",
//     messagesNumber: 8,
//     numberStudent: 0,
//     proposalNumber: 2,
//     title: "Senior frontend developer (Fintech)",
//   ),
//   JobModel(
//     HiredNumber: 0,
//     createAt: "Create 3 days ago",
//     discription: "Clear expectation about your project or deliverables",
//     messagesNumber: 8,
//     numberStudent: 0,
//     proposalNumber: 2,
//     title: "Senior frontend developer (Fintech)",
//   ),
//   JobModel(
//     HiredNumber: 0,
//     createAt: "Create 3 days ago",
//     discription: "Clear expectation about your project or deliverables",
//     messagesNumber: 8,
//     numberStudent: 0,
//     proposalNumber: 2,
//     title: "Senior frontend developer (Fintech)",
//   ),
//   JobModel(
//     HiredNumber: 0,
//     createAt: "Create 3 days ago",
//     discription: "Clear expectation about your project or deliverables",
//     messagesNumber: 8,
//     numberStudent: 0,
//     proposalNumber: 2,
//     title: "Senior frontend developer (Fintech)",
//   ),
// ];

class DashBoard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final role = context.read<AuthenticateProvider>().authenRepository.role;

    return FutureBuilder(
        future: role == "company"
            ? context.watch<JobNotifier>().getDashboardProject(
                token: context
                    .read<AuthenticateProvider>()
                    .authenRepository
                    .token!,
                companyId: context
                    .read<AuthenticateProvider>()
                    .authenRepository
                    .company?['id'])
            : context.watch<JobNotifier>().getProposalOfStudent(
                token: context
                    .read<AuthenticateProvider>()
                    .authenRepository
                    .token!,
                studentId: context
                    .read<AuthenticateProvider>()
                    .authenRepository
                    .student?['id']),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          List<Map<String, dynamic>> jobList = snapshot.data?['result'];

          return Container(
            decoration: BoxDecoration(
                color: Get.isDarkMode
                    ? Themes.backgroundDark
                    : Themes.backgroundLight),
            child: Padding(
              padding: const EdgeInsets.all(0),
              child: Container(
                child: Column(
                  children: [
                    Container(
                      height: 50,
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          color: Get.isDarkMode
                              ? Themes.boxDark
                              : Themes.boxLight),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(Languages.of(context)!.projects,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white)),
                          if (context
                                  .read<AuthenticateProvider>()
                                  .authenRepository
                                  .role ==
                              StudentHubCategorySignUp.company.name)
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  elevation: 0.2,
                                  minimumSize: Size(30, 30),
                                ),
                                onPressed: () {
                                  Navigator.push(context, MaterialPageRoute(
                                    builder: (context) {
                                      return ProjectPost_1();
                                    },
                                  ));
                                },
                                child: Text(
                                  Languages.of(context)!.postJob,
                                  style: TextStyle(
                                      color: Get.isDarkMode
                                          ? Themes.backgroundLight
                                          : Themes.backgroundDark),
                                ))
                        ],
                      ),
                    ),
                    Expanded(
                        child: Container(
                      child: CustomTabBar(
                        lengOfTabBar: 3,
                        tabs: [
                          Text(Languages.of(context)!.allProject),
                          Text(Languages.of(context)!.working),
                          Text(Languages.of(context)!.archive),
                        ],
                        tab_views: [
                          AllProjectWidget(
                            jobList: jobList.where((element) {
                              return element['deletedAt'] == null;
                            }).toList(),
                            state: JobState.pending.name,
                          ),
                          AllProjectWidget(
                            jobList: jobList.where((element) {
                              return element['deletedAt'] == null &&
                                  element['typeFlag'] == 1;
                            }).toList(),
                            state: JobState.working.name,
                          ),
                          AllProjectWidget(
                            jobList: jobList.where((element) {
                              return element['deletedAt'] == null &&
                                  element['typeFlag'] == 2;
                            }).toList(),
                            state: JobState.archieved.name,
                          ),
                        ],
                      ),
                    ))
                  ],
                ),
              ),
            ),
          );
        });
  }
}

class AllProjectWidget extends StatelessWidget {
  AllProjectWidget({super.key, required this.state, required this.jobList});
  String? state;
  List<Map<String, dynamic>> jobList;
  @override
  Widget build(BuildContext context) {
    final role = context.read<AuthenticateProvider>().authenRepository.role;
    final activeJobs = jobList
        .where((element) => element['statusFlag'] == statusFlag['Active'])
        .toList();
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (role == "student")
            Text(
              "${Languages.of(context)!.archive} (${activeJobs.length})",
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
          if (role == "student")
            Text(
              "${Languages.of(context)!.proposal} (${jobList.length})",
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
          Expanded(
            child: ListView.builder(
              itemCount: jobList.length,
              itemBuilder: (context, index) {
                JobModel job = JobModel.jsonFrom(jobList[index]);
                print(jobList[index]['statusFlag']);
                return GestureDetector(
                  onTap: role == "company"
                      ? () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) {
                              return ManageProject(
                                job: job,
                                proposals: job.proposals!,
                              );
                            },
                          ));
                        }
                      : null,
                  child: Container(
                    margin: EdgeInsets.only(top: 5),
                    height: role == "company" ? 180 : 125,
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      color: Get.isDarkMode
                          ? Themes.boxDecorationDark
                          : Themes.boxDecorationLight,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                job.title!,
                                overflow: TextOverflow.ellipsis,
                                maxLines:
                                    2, // Số dòng tối đa trước khi xuống hàng
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.copyWith(fontWeight: FontWeight.bold),
                              ),
                            ),
                            if (role == "company")
                              SizedBox(
                                  height: 30,
                                  child: PopupMenuButton(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(30)),
                                    color: Get.isDarkMode
                                        ? Themes.backgroundDark
                                        : Themes.backgroundLight,
                                    itemBuilder: (context) {
                                      return [
                                        PopupMenuItem(
                                            onTap: () {
                                              Navigator.of(context)
                                                  .push(MaterialPageRoute(
                                                builder: (context) {
                                                  return ManageProject(
                                                    selectIndex: 0,
                                                    job: job,
                                                    proposals: job.proposals!,
                                                  );
                                                },
                                              ));
                                            },
                                            child: Text(Languages.of(context)!
                                                .viewProposal)),
                                        PopupMenuItem(
                                            onTap: () {},
                                            child: Text(Languages.of(context)!
                                                .viewMessage)),
                                        PopupMenuItem(
                                            onTap: () {
                                              Navigator.of(context)
                                                  .push(MaterialPageRoute(
                                                builder: (context) {
                                                  return ManageProject(
                                                    selectIndex: 3,
                                                    job: job,
                                                    proposals: job.proposals!,
                                                  );
                                                },
                                              ));
                                            },
                                            child: Text(Languages.of(context)!
                                                .viewHired)),
                                        PopupMenuItem(
                                            onTap: () {},
                                            child: Text(Languages.of(context)!
                                                .viewJobPosting)),
                                        PopupMenuItem(
                                            onTap: () {},
                                            child: Text(Languages.of(context)!
                                                .exitPosting)),
                                        PopupMenuItem(
                                            onTap: () async {
                                              await context
                                                  .read<JobNotifier>()
                                                  .deleteJob(
                                                      token: context
                                                          .read<
                                                              AuthenticateProvider>()
                                                          .authenRepository
                                                          .token!,
                                                      id: job.id!);
                                            },
                                            child: Text(Languages.of(context)!
                                                .removePosting)),
                                        PopupMenuItem(
                                            onTap: () {
                                              // context.read<JobNotifier>().updateJob(id: job.id!, state: JobState.working.name);
                                            },
                                            child: Text(Languages.of(context)!
                                                .startWorking)),
                                      ];
                                    },
                                  ))
                          ],
                        ),
                        Text(job.createAt!),
                        Text(Languages.of(context)!.lookingFor),
                        Text(
                          "${"-\r${job.description}"}",
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                        if (role == "company")
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Container(
                                  alignment: Alignment.center,
                                  child: Column(
                                    children: [
                                      Container(
                                          alignment: Alignment.center,
                                          height: 25,
                                          width: 20,
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                  color: Get.isDarkMode
                                                      ? Themes.backgroundLight
                                                      : Themes.backgroundDark)),
                                          child: Text("${job.proposalNumber}")),
                                      Text(Languages.of(context)!.proposal)
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  alignment: Alignment.center,
                                  child: Column(
                                    children: [
                                      Container(
                                          alignment: Alignment.center,
                                          height: 25,
                                          width: 20,
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                  color: Get.isDarkMode
                                                      ? Themes.backgroundLight
                                                      : Themes.backgroundDark)),
                                          child: Text("${job.messagesNumber}")),
                                      Text(Languages.of(context)!.message)
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  alignment: Alignment.center,
                                  child: Column(
                                    children: [
                                      Container(
                                          alignment: Alignment.center,
                                          height: 25,
                                          width: 20,
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                  color: Get.isDarkMode
                                                      ? Themes.backgroundLight
                                                      : Themes.backgroundDark)),
                                          child: Text("${job.hiredNumber}")),
                                      Text(Languages.of(context)!.hired)
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          )
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
