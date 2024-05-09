import 'package:final_project_advanced_mobile/feature/auth/provider/authenticate_provider.dart';
import 'package:final_project_advanced_mobile/feature/callvideo/callvideo.dart';
import 'package:final_project_advanced_mobile/feature/chat/views/chat_message.dart';
import 'package:final_project_advanced_mobile/feature/notification/provider/notify_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        body: FutureBuilder(
          future: context.read<NotiProvider>().fetchDataAllNoti(
                token: context
                    .read<AuthenticateProvider>()
                    .authenRepository
                    .token!,
                userId:
                    context.read<AuthenticateProvider>().authenRepository.id!,
              ),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else {
              final notificationsList = snapshot.data;
              return Column(
                children: [
                  const TabBar(
                    tabs: [
                      Tab(text: 'All'),
                      Tab(text: 'Interview'),
                      Tab(text: 'Message'),
                      Tab(text: 'Other'),
                    ],
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        buildNotificationList(
                          context,
                          notificationsList,
                          (noti) => true, // All notifications
                        ),
                        buildNotificationList(
                          context,
                          notificationsList,
                          (noti) => noti['typeNotifyFlag'] == '1', // Interview
                        ),
                        buildNotificationList(
                          context,
                          notificationsList,
                          (noti) => noti['typeNotifyFlag'] == '3', // Message
                        ),
                        buildNotificationList(
                          context,
                          notificationsList,
                          (noti) =>
                              noti['typeNotifyFlag'] != '1' &&
                              noti['typeNotifyFlag'] != '3', // Other
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }

  Widget buildNotificationList(BuildContext context,
      List<dynamic>? notifications, bool Function(dynamic) filter) {
    final filteredList = notifications?.where(filter).toList() ?? [];

    return Container(
      padding: const EdgeInsets.all(8),
      child: ListView.builder(
        itemCount: filteredList.length,
        itemBuilder: (context, index) {
          final notification = filteredList[index];
          return Container(
            margin: const EdgeInsets.only(top: 10),
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('${notification['title']}'),
                                if (notification['notifyFlag'] == '0')
                                  Container(
                                    width: 10,
                                    height: 10,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.red,
                                    ),
                                  )
                                else
                                  const SizedBox.shrink(),
                              ],
                            ),
                            Container(
                              child: notification['typeNotifyFlag'] == '1' &&
                                      notification['message']['interview']
                                              ['deletedAt'] ==
                                          null
                                  ? ElevatedButton(
                                      onPressed: () async {
                                        await Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => CallPage(
                                              callID: notification['message']
                                                          ['interview']
                                                      ['meetingRoom']['id']
                                                  .toString(),
                                              userName: notification['receiver']
                                                  ['fullname'],
                                              userId: notification['receiver']
                                                      ['id']
                                                  .toString(),
                                            ),
                                          ),
                                        );
                                      },
                                      child: const Text('Start Interview'),
                                    )
                                  : notification['typeNotifyFlag'] == '3'
                                      ? ElevatedButton(
                                          onPressed: () async {
                                            await Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    ChatScreen(
                                                  nameReceiver:
                                                      notification['sender']
                                                          ['fullname'],
                                                  projectId:
                                                      notification['message']
                                                          ['projectId'],
                                                  receiveId:
                                                      notification['sender']
                                                          ['id'],
                                                ),
                                              ),
                                            );
                                          },
                                          child: const Text('Go Chatting'),
                                        )
                                      : null,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
