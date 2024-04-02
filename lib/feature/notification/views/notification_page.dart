import 'package:final_project_advanced_mobile/feature/notification/models/notication_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

List<NoticationModel> notificationsList = [
  NoticationModel(
      content: "You have submitted to join project \"Javis - AI Copilot\"",
      type: NoticationType.submitted.name,
      createAt: DateTime.now().toIso8601String()),
  NoticationModel(
      content:
          "You have invited to interview for project \"Javis - AI Copilot\" at 14:00 March 20, Thursday",
      type: NoticationType.invited.name,
      createAt: DateTime.now().toIso8601String()),
  NoticationModel(
      content: "You have offder to join project \"Javis - AI Copilot\"",
      type: NoticationType.offered.name,
      createAt: DateTime.now().toIso8601String()),
];

class NoticationPage extends StatelessWidget {
  const NoticationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      child: ListView.builder(
        itemCount: notificationsList.length,
        itemBuilder: (context, index) {
          NoticationModel notification = notificationsList[index];
          return Container(
            margin: EdgeInsets.only(top: 10),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                        flex: 2, child: Image.asset("assets/images/logo.png")),
                    Expanded(
                        flex: 8,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              child: Text(notification.content!),
                            ),
                            Container(
                              child: Text(notification.createAt!),
                            ),
                          ],
                        )),
                  ],
                ),
                if (notification.type == NoticationType.invited.name)
                  ElevatedButton(onPressed: () {}, child: Text("invite")),
                if (notification.type == NoticationType.offered)
                  ElevatedButton(onPressed: () {}, child: Text("view offer"))
              ],
            ),
          );
        },
      ),
    );
  }
}
