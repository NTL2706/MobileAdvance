// ignore_for_file: must_be_immutable, prefer_const_constructors, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './schedule.dart';
import '../constants/chat_type.dart';
import '../provider/chat_provider.dart';
import '../utils/convert_time.dart';

class ChatScreen extends StatefulWidget {
  final ChatUser chatUser;

  ChatScreen({required this.chatUser});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ChatProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.chatUser.name),
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
              // Xử lý khi một mục được chọn
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
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: provider.chatmessage.length,
              itemBuilder: (context, index) {
                if (provider
                        .chatmessage[provider.chatmessage.length - index - 1]
                    is ShecduleMeeting) {
                  return MeetingCard(
                    author: provider
                        .chatmessage[provider.chatmessage.length - index - 1]
                        .author,
                    title: provider
                        .chatmessage[provider.chatmessage.length - index - 1]
                        .title,
                    timeStart: provider
                        .chatmessage[provider.chatmessage.length - index - 1]
                        .timeStart,
                    timeEnd: provider
                        .chatmessage[provider.chatmessage.length - index - 1]
                        .timeEnd,
                  );
                } else {
                  final int lastIndex = provider.chatmessage.length - index - 1;
                  final message =
                      lastIndex >= 0 ? provider.chatmessage[lastIndex] : null;

                  final int nextIndex = lastIndex - 1;
                  final nextmessage = nextIndex >= 0 &&
                          provider.chatmessage[nextIndex] is ChatMessage
                      ? provider.chatmessage[nextIndex]
                      : null;

                  final int prevIndex = lastIndex + 1;
                  final prevmessage = prevIndex < provider.chatmessage.length &&
                          provider.chatmessage[prevIndex] is ChatMessage
                      ? provider.chatmessage[prevIndex]
                      : null;

                  return ChatBubble(
                    message: message!,
                    isMe: message != null &&
                        message.sender ==
                            'Me', // Kiểm tra message không phải null trước khi truy cập thuộc tính sender
                    isFirst: prevmessage == null ||
                        prevmessage?.sender !=
                            message
                                .sender, // Kiểm tra prevmessage không phải null trước khi truy cập thuộc tính sender
                    isLast: nextmessage == null ||
                        nextmessage?.sender !=
                            message
                                .sender, // Kiểm tra nextmessage không phải null trước khi truy cập thuộc tính sender
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
                          color: Colors.grey[200], // Màu nền của hộp đựng
                        ),
                        child: TextField(
                          style: TextStyle(fontSize: 18),
                          controller: provider.textController,
                          decoration: InputDecoration(
                            hintText: 'Enter your message...',
                            border:
                                InputBorder.none, // Loại bỏ viền của TextField
                            contentPadding: EdgeInsets.all(
                                16), // Khoảng cách giữa nội dung và mép hộp đựng
                          ),
                          onSubmitted: (text) => provider.handleSubmitted(text),
                        ),
                      ),
                    ),
                    SizedBox(width: 12),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Colors.blue, // Màu nền của nút IconButton
                      ),
                      child: IconButton(
                        icon: Icon(Icons.send_rounded),
                        color: Colors.white, // Màu của Icon
                        onPressed: () {
                          provider.handleSubmitted(provider.textController
                              .text); // Xử lý khi nhấn nút IconButton
                          FocusScope.of(context).unfocus(); // Ẩn bàn phím
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class ChatBubble extends StatelessWidget {
  final ChatMessage message;
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
                message.text,
                style: TextStyle(
                    color: isMe ? Colors.white : Colors.black, fontSize: 20),
              ),
              Text(
                getTimeFromDateTime(message.time).toString(),
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
  final String author;
  final String title;
  final DateTime timeStart;
  final DateTime timeEnd;
  final int duration;

  MeetingCard({
    required this.author,
    required this.title,
    required this.timeStart,
    required this.timeEnd,
    this.duration = 60, // Default duration is 60 minutes
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 4, right: 8, left: 8),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Created by: $author',
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
                    title,
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
              'Start Time: ${getDateTime(timeStart)}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'End Time: ${getDateTime(timeEnd)}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Handle join meeting
                  },
                  child: Text('Join'),
                ),
                IconButton(
                  onPressed: () {
                    // Handle more options
                  },
                  icon: Icon(Icons.more_vert),
                ),
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
