import 'package:final_project_advanced_mobile/feature/auth/provider/authenticate_provider.dart';
import 'package:final_project_advanced_mobile/feature/notification/models/notication_model.dart';
import 'package:final_project_advanced_mobile/feature/notification/provider/notify_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({Key? key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: context.read<NotiProvider>().fetchDataAllNoti(
            token: context.read<AuthenticateProvider>().authenRepository.token!,
            userId: context.read<AuthenticateProvider>().authenRepository.id!,
          ),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else {
          final notificationsList = snapshot.data ?? [];
          return Container(
            padding: EdgeInsets.all(8),
            child: ListView.builder(
              itemCount: snapshot.data?.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Image.asset("assets/images/logo.png"),
                          ),
                          Expanded(
                            flex: 8,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    child: Text(""),
                                  ),
                                  Container(
                                    child: Text(""),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      // if (notification.type == NoticationType.invited.name)
                      //   ElevatedButton(
                      //     onPressed: () {},
                      //     child: Text("Invite"),
                      //   ),
                      // if (notification.type == NoticationType.offered.name)
                      //   ElevatedButton(
                      //     onPressed: () {},
                      //     child: Text("View Offer"),
                      //   ),
                    ],
                  ),
                );
              },
            ),
          );
        }
      },
    );
  }
}
