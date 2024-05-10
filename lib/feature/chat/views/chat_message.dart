// ignore_for_file: must_be_immutable, prefer_const_constructors, sort_child_properties_last, use_build_context_synchronously

import 'package:final_project_advanced_mobile/back_service.dart';
import 'package:final_project_advanced_mobile/constants/status_flag.dart';
import 'package:final_project_advanced_mobile/feature/auth/provider/authenticate_provider.dart';
import 'package:final_project_advanced_mobile/languages/language.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './schedule.dart';
import '../constants/chat_type.dart';
import '../provider/chat_provider.dart';
import '../utils/convert_time.dart';
import '../utils/calc_duration.dart';
import '../../callvideo/callvideo.dart';

class ChatScreen extends StatefulWidget {
  final String nameReceiver;
  final int projectId;
  final int receiveId;
  int? proposalId;
  ChatScreen(
      {required this.projectId,
      required this.receiveId,
      required this.nameReceiver,
      this.proposalId});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final ScrollController _scrollController = ScrollController();

  late ChatProvider chatProvider;
  late SocketManager socketManager;
  void scrollToBottom() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  @override
  void initState() {
    super.initState();
    chatProvider = context.read<ChatProvider>();
    socketManager = chatProvider.initSocket(
        provider: chatProvider,
        token: context.read<AuthenticateProvider>().authenRepository.token!,
        projectId: widget.projectId.toString());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    socketManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    socketManager.socket?.on("RECEIVE_MESSAGE", (data) {
      chatProvider.addMessage(
          id: data['notification']['id'],
          message: data['notification']['message']['content'],
          createdAt: DateTime.now(),
          sender: User(
              id: data['notification']['sender']['id'],
              fullname: data['notification']['sender']['fullname']),
          receiver: User(
              id: data['notification']['receiver']['id'],
              fullname: data['notification']['receiver']['fullname']),
          interview: null);
    });

    socketManager.socket?.on("RECEIVE_INTERVIEW", (data) {
      if (data['notification']['content'] == 'Interview created') {
        chatProvider.addMessage(
            id: data['notification']['id'],
            message: 'Interview created',
            createdAt: DateTime.now(),
            sender: User(
                id: data['notification']['sender']['id'],
                fullname: data['notification']['sender']['fullname']),
            receiver: User(
                id: data['notification']['receiver']['id'],
                fullname: data['notification']['receiver']['fullname']),
            interview: Interview(
                id: data['notification']['message']['interview']['id'],
                createdAt: DateTime.parse(
                    data['notification']['message']['interview']['createdAt']),
                updatedAt: DateTime.parse(
                    data['notification']['message']['interview']['updatedAt']),
                deletedAt: null,
                startTime: DateTime.parse(
                    data['notification']['message']['interview']['startTime']),
                endTime: DateTime.parse(
                    data['notification']['message']['interview']['endTime']),
                title: data['notification']['message']['interview']['title'],
                disableFlag: 0,
                meetingRoomId: data['notification']['message']['interview']
                    ['meetingRoomId']));
      } else if (data['notification']['content'] == 'Interview updated') {
        chatProvider.updateScheduleMeeting(
            title: data['notification']['message']['interview']['title'],
            startTime: DateTime.parse(
                data['notification']['message']['interview']['startTime']),
            endTime: DateTime.parse(
                data['notification']['message']['interview']['endTime']),
            interviewId: data['notification']['message']['interview']['id']);
      }
    });
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop(true);
            },
            icon: Icon(Icons.arrow_back)),
        automaticallyImplyLeading: false,
        scrolledUnderElevation: 0,
        title: Text(widget.nameReceiver),
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
                child: Text(Languages.of(context)!.scheduleMeeting),
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
                      return MeetingScheduleBottomSheet(
                        socketManager: socketManager,
                        sender: context
                            .read<AuthenticateProvider>()
                            .authenRepository
                            .id!,
                        receiver: widget.receiveId,
                        projectid: widget.projectId,
                      );
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
              projectid: widget.projectId,
              userid: widget.receiveId),
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
                      reverse: true,
                      controller: _scrollController,
                      itemCount:
                          context.watch<ChatProvider>().messages?.length ?? 0,
                      itemBuilder: (context, index) {
                        if (snapshot.data?[index].interview != null) {
                          return MeetingCard(
                            socketManager: socketManager,
                            projectid: widget.projectId,
                            sender: snapshot.data![index].sender,
                            receiver: snapshot.data![index].receiver,
                            interview: snapshot.data![index].interview!,
                          );
                        } else {
                          Widget dateWidget = Container();
                          bool isMe = snapshot.data?[index].sender.id ==
                              context
                                  .watch<AuthenticateProvider>()
                                  .authenRepository
                                  .id;

                          final message = snapshot.data?[index].content;

                          final int nextIndex = index + 1;
                          final nextmessage = nextIndex >= snapshot.data!.length
                              ? null
                              : snapshot.data?[index].content;

                          final int prevIndex = index - 1;
                          final prevmessage = prevIndex <= 0
                              ? null
                              : snapshot.data?[index].content;

                          bool shouldDisplayDateWidget(int index) {
                            print(index);
                            print(
                                '$index ${snapshot.data![index].createdAt.day} ${snapshot.data![index].createdAt.month} ${snapshot.data![index].content}');

                            if (snapshot.data!.length == 1) {
                              return true;
                            }
                            if (index > 0 &&
                                index < snapshot.data!.length - 1 &&
                                snapshot.data![index].createdAt.day >
                                    snapshot.data![index + 1].createdAt.day) {
                              return true;
                            } else if (index == snapshot.data!.length - 1 &&
                                snapshot.data![index].createdAt.day <
                                    snapshot.data![index - 1].createdAt.day) {
                              return true;
                            }

                            return false; // Mặc định không hiển thị
                          }

                          if (shouldDisplayDateWidget(index)) {
                            dateWidget = Padding(
                              padding: EdgeInsets.only(top: 8, bottom: 8),
                              child: Center(
                                  child: Text(
                                      '${snapshot.data![index].createdAt.day} - '
                                      '${snapshot.data![index].createdAt.month} - '
                                      '${snapshot.data![index].createdAt.year}')),
                            );
                          }

                          return Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: isMe
                                  ? CrossAxisAlignment.end
                                  : CrossAxisAlignment.start,
                              children: [
                                dateWidget,
                                ChatBubble(
                                  time: snapshot.data![index].createdAt,
                                  message: message!,
                                  isMe:
                                      isMe, // Kiểm tra message không phải null trước khi truy cập thuộc tính sender
                                  isFirst: prevmessage == null ||
                                      snapshot.data?[index].sender.id !=
                                          snapshot.data?[index - 1].sender.id ||
                                      snapshot.data?[index].createdAt.day !=
                                          snapshot.data?[index - 1].createdAt
                                              .day, // Kiểm tra prevmessage không phải null trước khi truy cập thuộc tính sender
                                  isLast: nextmessage == null ||
                                      snapshot.data?[index].sender.id !=
                                          snapshot.data?[index + 1].sender.id ||
                                      snapshot.data?[index].createdAt.day !=
                                          snapshot.data?[index + 1].createdAt
                                              .day, // Kiểm tra nextmessage không phải null trước khi truy cập thuộc tính sender
                                )
                              ]);
                        }
                      },
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Padding(
                      padding: EdgeInsets.only(
                          bottom: 12, right: 8, left: 8, top: 12),
                      child: Container(
                        color: Colors.transparent,
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  // color:
                                  //     Colors.grey[200], // Màu nền của hộp đựng
                                ),
                                child: TextField(
                                  style: TextStyle(fontSize: 18),
                                  controller: context
                                      .watch<ChatProvider>()
                                      .textController,
                                  decoration: InputDecoration(
                                    hintText:
                                        '${Languages.of(context)!.typeHere} ...',
                                    border: InputBorder
                                        .none, // Loại bỏ viền của TextField
                                    contentPadding: EdgeInsets.all(
                                        16), // Khoảng cách giữa nội dung và mép hộp đựng
                                  ),
                                  onSubmitted: (text) async {
                                    if (text.isNotEmpty) {
                                      socketManager.sendMessage(
                                          content: text,
                                          projectId: widget.projectId,
                                          receiverId: widget.receiveId,
                                          senderId: context
                                              .read<AuthenticateProvider>()
                                              .authenRepository
                                              .id!,
                                          messageFlag: 0);

                                      context
                                          .read<ChatProvider>()
                                          .textController
                                          .clear();

                                      final messages =
                                          context.read<ChatProvider>().messages;

                                      if (messages != null &&
                                          messages.isEmpty) {
                                        await context
                                            .read<ChatProvider>()
                                            .updateStatusOfStudetnProposal(
                                                statusFlag:
                                                    statusFlag['active']!,
                                                proposalId: widget.proposalId!,
                                                token: context
                                                    .read<
                                                        AuthenticateProvider>()
                                                    .authenRepository
                                                    .token!);
                                      }
                                    }
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
                                onPressed: () async {
                                  if (context
                                      .watch<ChatProvider>()
                                      .textController
                                      .text
                                      .isNotEmpty) {
                                    socketManager.sendMessage(
                                        content: context
                                            .watch<ChatProvider>()
                                            .textController
                                            .text,
                                        projectId: widget.projectId,
                                        receiverId: widget.receiveId,
                                        senderId: context
                                            .read<AuthenticateProvider>()
                                            .authenRepository
                                            .id!,
                                        messageFlag: 0);

                                    context
                                        .read<ChatProvider>()
                                        .textController
                                        .clear();

                                    final messages =
                                        context.read<ChatProvider>().messages;

                                    if (messages != null && messages.isEmpty) {
                                      await context
                                          .read<ChatProvider>()
                                          .updateStatusOfStudetnProposal(
                                              statusFlag: statusFlag['Actice']!,
                                              proposalId: widget.proposalId!,
                                              token: context
                                                  .read<AuthenticateProvider>()
                                                  .authenRepository
                                                  .token!);
                                    }
                                  }

                                  FocusScope.of(context).unfocus();
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
  final DateTime time;

  const ChatBubble(
      {required this.message,
      required this.isMe,
      required this.isFirst,
      required this.isLast,
      required this.time});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(
              top: isLast ? 20.0 : 4.0,
              right: isMe ? 12 : 48,
              left: isMe ? 48 : 12),
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: isMe ? Colors.blue : Colors.grey[300],
            borderRadius: isMe
                ? BorderRadius.only(
                    topLeft: Radius.circular(16.0),
                    topRight: Radius.circular(isLast ? 16 : 8),
                    bottomLeft: Radius.circular(16.0),
                    bottomRight: Radius.circular(isFirst ? 16 : 8),
                  )
                : BorderRadius.only(
                    topRight: Radius.circular(16),
                    topLeft: Radius.circular(isLast ? 16 : 8),
                    bottomRight: Radius.circular(16),
                    bottomLeft: Radius.circular(isFirst ? 16 : 8),
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
                '${time.hour}:${time.minute.toString().padLeft(2, '0')}',
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
  int projectid;
  Interview interview;
  User sender;
  User receiver;
  SocketManager socketManager;

  MeetingCard({
    required this.projectid,
    required this.interview,
    required this.sender,
    required this.receiver,
    required this.socketManager,
  });

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ChatProvider>(context);
    final int duration =
        calculateTimeDifference(interview.startTime, interview.endTime);

    return Container(
      margin: EdgeInsets.only(top: 4, right: 12, left: 12),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${Languages.of(context)!.createdBy}: ${sender.fullname}',
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
                    interview.title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  '${Languages.of(context)!.duration}: $duration minutes',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Text(
              '${Languages.of(context)!.startTime}: ${getDateTime(interview.startTime)}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              '${Languages.of(context)!.endTime}: ${getDateTime(interview.endTime)}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                interview.deletedAt == null
                    ? ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CallPage(
                                token: context
                                    .watch<AuthenticateProvider>()
                                    .authenRepository
                                    .token!,
                                interviewId: interview.id,
                                userName: context
                                    .watch<AuthenticateProvider>()
                                    .authenRepository
                                    .username!,
                                userId: context
                                    .watch<AuthenticateProvider>()
                                    .authenRepository
                                    .id!
                                    .toString(),
                                callID: interview.meetingRoomId.toString(),
                              ),
                            ),
                          );
                          // Handle join meeting
                        },
                        child: Text(Languages.of(context)!.join),
                      )
                    : Text(
                        Languages.of(context)!.cancelMeeting,
                        style: TextStyle(
                            color: Colors.red, fontWeight: FontWeight.bold),
                      ),
                sender.id ==
                            context
                                .watch<AuthenticateProvider>()
                                .authenRepository
                                .id &&
                        interview.deletedAt == null
                    ? PopupMenuButton(
                        elevation: 50,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: EdgeInsets.zero,
                        icon: Icon(Icons.more_vert),
                        itemBuilder: (BuildContext context) => <PopupMenuEntry>[
                          PopupMenuItem(
                            child: Text(Languages.of(context)!.edit),
                            value: 1,
                          ),
                          PopupMenuItem(
                            child: Text(Languages.of(context)!.cancel),
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
                                    socketManager: socketManager,
                                    interview: interview,
                                    sender: sender.id,
                                    receiver: receiver.id,
                                    projectid: projectid,
                                  );
                                },
                              );
                              break;
                            case 2:
                              socketManager.deleteSchedule(
                                  interviewId: interview.id);
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
