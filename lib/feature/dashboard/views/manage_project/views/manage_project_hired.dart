import 'package:final_project_advanced_mobile/constants/colors.dart';
import 'package:final_project_advanced_mobile/languages/language.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

class ManageProjectHired extends StatelessWidget {
  ManageProjectHired({super.key, required this.proposals});

  List<Map<String, dynamic>> proposals;
  @override
  Widget build(BuildContext context) {
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
                color: Colors.grey.shade200),
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
                          elevation: 0.5, backgroundColor: Colors.white),
                      child: Text(
                        Languages.of(context)!.message,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      onPressed: () {},
                    )),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          elevation: 0.5, backgroundColor: Colors.white),
                      child: Text(Languages.of(context)!.hired,
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  )),
                      onPressed: () {},
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
