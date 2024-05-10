import 'package:final_project_advanced_mobile/constants/noti_type_flag.dart';
import 'package:final_project_advanced_mobile/constants/status_flag.dart';
import 'package:final_project_advanced_mobile/constants/type_flag.dart';
import 'package:final_project_advanced_mobile/feature/auth/provider/authenticate_provider.dart';
import 'package:final_project_advanced_mobile/feature/callvideo/callvideo.dart';
import 'package:final_project_advanced_mobile/feature/chat/provider/chat_provider.dart';
import 'package:final_project_advanced_mobile/feature/chat/views/chat_message.dart';
import 'package:final_project_advanced_mobile/feature/notification/provider/notify_provider.dart';
import 'package:final_project_advanced_mobile/languages/language.dart';
import 'package:final_project_advanced_mobile/feature/projects/provider/project_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/quickalert.dart';

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
              final notificationsList = context.watch<NotiProvider>().notiList;
              return Column(
                children: [
                  TabBar(
                    tabs: [
                      Tab(text: Languages.of(context)!.all),
                      Tab(text: Languages.of(context)!.interview),
                      Tab(text: Languages.of(context)!.message),
                      Tab(text: Languages.of(context)!.other),
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
                          (noti) =>
                              noti['typeNotifyFlag'] ==
                              TypeNotifyFlag['Interview']
                                  .toString(), // Interview
                        ),
                        buildNotificationList(
                          context,
                          notificationsList,
                          (noti) =>
                              noti['typeNotifyFlag'] ==
                              TypeNotifyFlag['Chat'].toString(), // Message
                        ),
                        buildNotificationList(
                          context,
                          notificationsList,
                          (noti) =>
                              noti['typeNotifyFlag'] !=
                                  TypeNotifyFlag['Interview'].toString() &&
                              noti['typeNotifyFlag'] !=
                                  TypeNotifyFlag['Chat'].toString(), // Other
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
          final notification = filteredList[filteredList.length - 1 - index];
          return Container(
            margin: const EdgeInsets.only(top: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: 3,
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
                                Flexible(
                                  flex: 8, // Adjust the flex value as needed
                                  child: Text(
                                    '${notification['title']}',
                                    overflow: TextOverflow
                                        .clip, // Prevents overflow issues
                                    maxLines:
                                        2, // Set this to your preferred number of lines
                                    softWrap:
                                        true, // Allows word breaking and line wrapping
                                    style: const TextStyle(
                                        fontSize:
                                            16), // Optional: Customize as needed
                                  ),
                                ),
                                notification['notifyFlag'] == '0'
                                    ? IconButton(
                                        icon: const Icon(Icons.check),
                                        onPressed: () {
                                          context.read<NotiProvider>().readNoti(
                                              notification['id'],
                                              context
                                                  .read<AuthenticateProvider>()
                                                  .authenRepository
                                                  .token!); // Call the desired function
                                        },
                                        color: Colors
                                            .green, // Adjust the color of the tick icon
                                      )
                                    : const SizedBox
                                        .shrink(), // Use an empty widget if the notifyFlag is not '0'.
                              ],
                            ),
                            Text('${notification['content']}',
                                overflow: TextOverflow.clip,
                                maxLines: 2,
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12,
                                )),
                            SizedBox(
                              height: 50,
                              child: notification['typeNotifyFlag'] ==
                                          TypeNotifyFlag['Interview']
                                              .toString() &&
                                      notification['message']['interview']
                                              ['deletedAt'] ==
                                          null
                                  ? ElevatedButton(
                                      onPressed: () async {
                                        await Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => CallPage(
                                              interviewId:
                                                  notification['message']
                                                      ['interview']['id'],
                                              token: context
                                                  .read<AuthenticateProvider>()
                                                  .authenRepository
                                                  .token!,
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
                                      child: Text(Languages.of(context)!
                                          .startInterview),
                                    )
                                  : notification['typeNotifyFlag'] ==
                                          TypeNotifyFlag['Chat'].toString()
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
                                          child: Text(
                                              Languages.of(context)!.goChat),
                                        )
                                      : notification['typeNotifyFlag'] ==
                                              TypeNotifyFlag['Offer'].toString()
                                          ? Row(
                                              children: [
                                                ElevatedButton(
                                                  onPressed: () {},
                                                  child: const Text('Decline'),
                                                ),
                                                const SizedBox(width: 10),
                                                ElevatedButton(
                                                  onPressed: () async {
                                                    await context
                                                        .read<ChatProvider>()
                                                        .updateStatusOfStudetnProposal(
                                                            proposalId:
                                                                notification[
                                                                    'proposalId'],
                                                            token: context
                                                                .read<
                                                                    AuthenticateProvider>()
                                                                .authenRepository
                                                                .token!,
                                                            statusFlag:
                                                                statusFlag[
                                                                    'Hired']!);

                                                    await context
                                                        .read<ProjectProvider>()
                                                        .updateProject(
                                                            typeFlag: typeFlag[
                                                                'Working'],
                                                            token: context
                                                                .read<
                                                                    AuthenticateProvider>()
                                                                .authenRepository
                                                                .token!,
                                                            projectId: notification[
                                                                    'proposal']
                                                                ['projectId']);
                                                    print(context
                                                        .read<ProjectProvider>()
                                                        .responseHttp
                                                        .result);
                                                    await QuickAlert.show(
                                                        text: "Let's cooperate",
                                                        confirmBtnText: "OK",
                                                        cancelBtnText: "CANCEL",
                                                        onConfirmBtnTap: () {
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                        onCancelBtnTap: () {
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                        context: context,
                                                        showCancelBtn: true,
                                                        type: QuickAlertType
                                                            .success);
                                                  },
                                                  child: const Text(
                                                      'Congratulation!'),
                                                ),
                                              ],
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
