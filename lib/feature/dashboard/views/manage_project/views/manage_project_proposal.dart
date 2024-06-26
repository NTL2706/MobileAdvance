import 'package:final_project_advanced_mobile/constants/colors.dart';

import 'package:final_project_advanced_mobile/constants/status_flag.dart';
import 'package:final_project_advanced_mobile/constants/type_flag.dart';
import 'package:final_project_advanced_mobile/feature/auth/provider/authenticate_provider.dart';
import 'package:final_project_advanced_mobile/feature/chat/provider/chat_provider.dart';

import 'package:final_project_advanced_mobile/feature/chat/views/chat_message.dart';
import 'package:final_project_advanced_mobile/feature/dashboard/views/manage_project/models/student_models.dart';
import 'package:final_project_advanced_mobile/languages/language.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

import 'package:provider/provider.dart';

class ManageProjectProposal extends StatelessWidget {
  ManageProjectProposal({super.key, required this.proposals});
  List<Map<String, dynamic>> proposals;
  @override
  Widget build(BuildContext context) {
    print(proposals);
    proposals = proposals.where((element) => (element['statusFlag'].toString() == statusFlag['Waiting'].toString() || element['statusFlag'].toString() == statusFlag['Active'].toString() ),).toList();
    return Container(
      child: ListView.builder(
        itemCount: proposals.length,
        itemBuilder: (context, index) {
          final proposal = proposals[index];
          final date = DateTime.parse(proposal['createdAt'].toString());
          return Container(
            margin: EdgeInsets.only(bottom: 10),
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Get.isDarkMode
                    ? Themes.boxDecorationDark.withOpacity(0.5)
                    : Themes.boxDecorationLight.withOpacity(0.5)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    //avatar
                    Expanded(
                        flex: 2,
                        child: Image.asset('assets/images/avatar.png')),
                    //name and year
                    Expanded(
                        flex: 8,
                        child: Column(
                          children: [
                            Text(
                              '${proposal['student']['user']['fullname']}',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              '${date.day}-${date.month}-${date.year}',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(fontWeight: FontWeight.normal),
                            ),
                          ],
                        ))
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      proposal['student']['techStack']['name'],
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    // Text("excellent")
                  ],
                ),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Text("${proposal['coverLetter']}")),
                Row(
                  children: [
                    Expanded(
                        child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          elevation: 0.5,
                          backgroundColor: Get.isDarkMode
                              ? Themes.backgroundDark
                              : Themes.backgroundLight),
                      child: Text(
                        Languages.of(context)!.message,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ChatScreen(
                            projectId: proposal['projectId'],
                            receiveId: proposal['student']['userId'],
                            nameReceiver: proposal['student']['user']
                                ['fullname'],
                            proposalId: proposal['id'],
                          ),
                        ));
                      },
                    )),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          elevation: 0.5,
                          backgroundColor: Get.isDarkMode
                              ? Themes.backgroundDark
                              : Themes.backgroundLight),
                      child: Text(Languages.of(context)!.hired,
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  )),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              backgroundColor: Get.isDarkMode
                                  ? Themes.backgroundDark
                                  : Themes.backgroundLight,
                              actions: [
                                ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text(Languages.of(context)!.cancel)),
                                ElevatedButton(
                                  onPressed: () async {
                                    await context
                                        .read<ChatProvider>()
                                        .updateStatusOfStudetnProposal(
                                            proposalId: proposal['id'],
                                            token: context
                                                .read<AuthenticateProvider>()
                                                .authenRepository
                                                .token!,
                                            statusFlag: statusFlag['Offer']!);
                                    Navigator.of(context).pop();
                                  },
                                  child: Text(Languages.of(context)!.oke),
                                ),
                              ],
                              title: Text(Languages.of(context)!.hiredOffer),
                              content: Container(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(Languages.of(context)!
                                        .hiredOfferDescription)
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ))
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
