// ignore_for_file: must_be_immutable, prefer_const_constructors, sort_child_properties_last

import 'package:final_project_advanced_mobile/feature/auth/provider/authenticate_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './schedule.dart';
import '../constants/chat_type.dart';
import '../provider/chat_provider.dart';
import '../utils/convert_time.dart';
import '../utils/calc_duration.dart';

class ChatScreen extends StatelessWidget {
  final String nameReceiver;
  final int projectId;
  final int receiveId;
  final ScrollController _scrollController = ScrollController();

  ChatScreen(
      {required this.projectId,
      required this.receiveId,
      required this.nameReceiver});

  void scrollToBottom() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    SocketManager socket = context.read<ChatProvider>().initSocket(
        token: context.read<AuthenticateProvider>().authenRepository.token!,
        projectId: projectId.toString());

    return Scaffold(
      appBar: AppBar(
        title: Text(nameReceiver),
        actions: [
          PopupMenuButton(
            elevation: 50,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            padding: EdgeInsets.zero,
            icon: Icon(Icons.more_vert),
            itemBuilder: (BuildContext context) => <PopupMenuEntry>[
              PopupMenuItem(
                child: Text('Shecdule a new meeting'),
                value: 1,
              ),
              // Thêm các mục menu khác nếu cần
            ],
            onSelected: (value) {
              switch (value) {
                case 1:
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (BuildContext context) {
                      return MeetingScheduleBottomSheet();
                    },
                  );
                  break;
              }
            },
          ),
        ],
      ),
      body: FutureBuilder(
          future: context.read<ChatProvider>().fetchDataIdUser(
              token:
                  context.read<AuthenticateProvider>().authenRepository.token!,
              projectid: projectId,
              userid: receiveId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                  child:
                      CircularProgressIndicator()); // Hiển thị spinner khi dữ liệu đang được tải
            } else {
              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      controller: _scrollController,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        if (snapshot.data?[index].interview != null) {
                          return null;
                          // MeetingCard(
                          //   index:
                          //       context.watch<ChatProvider>().chatmessage.length -
                          //           index -
                          //           1,
                          // );
                        } else {
                          final int curIndex = index;
                          final message = snapshot.data?[index].content;

                          final int nextIndex = curIndex + 1;
                          final nextmessage = nextIndex >= snapshot.data!.length
                              ? null
                              : snapshot.data?[index].content;

                          final int prevIndex = curIndex - 1;
                          final prevmessage = prevIndex <= 0
                              ? null
                              : snapshot.data?[index].content;

                          return ChatBubble(
                            message: message!,
                            isMe: message != null &&
                                snapshot.data?[index].sender.id ==
                                    context
                                        .watch<AuthenticateProvider>()
                                        .authenRepository
                                        .id, // Kiểm tra message không phải null trước khi truy cập thuộc tính sender
                            isFirst: prevmessage == null ||
                                snapshot.data?[index].sender.id !=
                                    snapshot.data?[index - 1].sender
                                        .id, // Kiểm tra prevmessage không phải null trước khi truy cập thuộc tính sender
                            isLast: nextmessage == null ||
                                snapshot.data?[index].sender.id !=
                                    snapshot.data?[index + 1].sender
                                        .id, // Kiểm tra nextmessage không phải null trước khi truy cập thuộc tính sender
                          );
                        }
                      },
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 12, right: 8, left: 8),
                      child: Container(
                        color: Colors.transparent,
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color:
                                      Colors.grey[200], // Màu nền của hộp đựng
                                ),
                                child: TextField(
                                  style: TextStyle(fontSize: 18),
                                  controller: context
                                      .watch<ChatProvider>()
                                      .textController,
                                  decoration: InputDecoration(
                                    hintText: 'Enter your message...',
                                    border: InputBorder
                                        .none, // Loại bỏ viền của TextField
                                    contentPadding: EdgeInsets.all(
                                        16), // Khoảng cách giữa nội dung và mép hộp đựng
                                  ),
                                  onSubmitted: (text) => {
                                    text.isNotEmpty
                                        ? {
                                            socket.sendMessage(
                                                content: text,
                                                projectId: projectId,
                                                receiverId: receiveId,
                                                senderId: context
                                                    .read<
                                                        AuthenticateProvider>()
                                                    .authenRepository
                                                    .id!,
                                                messageFlag: 0),
                                            context
                                                .read<ChatProvider>()
                                                .textController
                                                .clear(),
                                          }
                                        : null,
                                  },
                                ),
                              ),
                            ),
                            SizedBox(width: 12),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color:
                                    Colors.blue, // Màu nền của nút IconButton
                              ),
                              child: IconButton(
                                icon: Icon(Icons.send_rounded),
                                color: Colors.white, // Màu của Icon
                                onPressed: () {
                                  context
                                          .watch<ChatProvider>()
                                          .textController
                                          .text
                                          .isNotEmpty
                                      ? {
                                          socket.sendMessage(
                                              content: context
                                                  .watch<ChatProvider>()
                                                  .textController
                                                  .text,
                                              projectId: projectId,
                                              receiverId: receiveId,
                                              senderId: context
                                                  .read<AuthenticateProvider>()
                                                  .authenRepository
                                                  .id!,
                                              messageFlag: 0),
                                          context
                                              .watch<ChatProvider>()
                                              .textController
                                              .clear()
                                        }
                                      : null;
                                  FocusScope.of(context).unfocus();
                                  scrollToBottom(); // Ẩn bàn phím
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              );
            }
          }),
    );
  }
}

class ChatBubble extends StatelessWidget {
  final String message;
  final bool isMe;
  final bool isFirst;
  final bool isLast;

  const ChatBubble(
      {required this.message,
      required this.isMe,
      required this.isFirst,
      required this.isLast});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(
              top: 4.0, right: isMe ? 8 : 0, left: isMe ? 0 : 8),
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: isMe ? Colors.blue : Colors.grey[300],
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16.0),
              topRight: Radius.circular(isFirst ? 16.0 : 0),
              bottomLeft: Radius.circular(16.0),
              bottomRight: Radius.circular(isLast ? 16.0 : 0.0),
            ),
          ),
          child: Column(
            crossAxisAlignment:
                isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              Text(
                message,
                style: TextStyle(
                    color: isMe ? Colors.white : Colors.black, fontSize: 20),
              ),
              Text(
                '11 - 00',
                // getTimeFromDateTime(message.time).toString(),
                style: TextStyle(
                    fontSize: 12.0, color: isMe ? Colors.white60 : Colors.grey),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class MeetingCard extends StatelessWidget {
  final int index;

  MeetingCard({
    required this.index, // Default duration is 60 minutes
  });

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ChatProvider>(context);
    final int duration = calculateTimeDifference(
        provider.chatmessage[index].timeStart,
        provider.chatmessage[index].timeEnd);

    return Container(
      margin: EdgeInsets.only(top: 4, right: 8, left: 8),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Created by: ${provider.chatmessage[index].author}',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    provider.chatmessage[index].title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  'Duration: $duration minutes',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Text(
              'Start Time: ${getDateTime(provider.chatmessage[index].timeStart)}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'End Time: ${getDateTime(provider.chatmessage[index].timeEnd)}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                provider.chatmessage[index].isMeeting == 1
                    ? ElevatedButton(
                        onPressed: () {
                          // Handle join meeting
                        },
                        child: Text('Join'),
                      )
                    : Text(
                        'This meeting has been canceled',
                        style: TextStyle(
                            color: Colors.red, fontWeight: FontWeight.bold),
                      ),
                provider.chatmessage[index].author == 'Me' &&
                        provider.chatmessage[index].isMeeting == 1
                    ? PopupMenuButton(
                        elevation: 50,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: EdgeInsets.zero,
                        icon: Icon(Icons.more_vert),
                        itemBuilder: (BuildContext context) => <PopupMenuEntry>[
                          PopupMenuItem(
                            child: Text('Edit Meeting'),
                            value: 1,
                          ),
                          PopupMenuItem(
                            child: Text('Cancel Meeting'),
                            value: 2,
                          ),
                          // Thêm các mục menu khác nếu cần
                        ],
                        onSelected: (value) {
                          // Xử lý khi một mục được chọn
                          switch (value) {
                            case 1:
                              showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                builder: (BuildContext context) {
                                  return MeetingScheduleBottomSheet(
                                      id: provider.chatmessage[index].id);
                                },
                              );
                              break;
                            case 2:
                              provider.handleCancelScheduleMeeting(
                                  provider.chatmessage[index].id);
                              break;
                          }
                        },
                      )
                    : SizedBox(),
              ],
            ),
          ],
        ),
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.black, width: 2),
          color: Colors.green[300]),
    );
  }
}
