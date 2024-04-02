// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: provider.chatmessage.length,
              itemBuilder: (context, index) {
                final int lastIndex = provider.chatmessage.length - index - 1;
                final message =
                    lastIndex >= 0 ? provider.chatmessage[lastIndex] : null;

                final int nextIndex = lastIndex - 1;
                final nextmessage =
                    nextIndex >= 0 ? provider.chatmessage[nextIndex] : null;

                final int prevIndex = lastIndex + 1;
                final prevmessage = prevIndex < provider.chatmessage.length
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
