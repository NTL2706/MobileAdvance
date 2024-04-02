import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants/chat_type.dart';
import '../provider/chat_provider.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ChatProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: provider.chatmessage.length,
              itemBuilder: (context, index) {
                final message = provider.chatmessage[index];
                return ChatBubble(
                  message: message,
                  isMe: message.sender == 'Me',
                );
              },
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: provider.textController,
                    decoration:
                        InputDecoration(hintText: 'Enter your message...'),
                    onSubmitted: (text) => provider.handleSubmitted(text),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () =>
                      provider.handleSubmitted(provider.textController.text),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ChatBubble extends StatelessWidget {
  final ChatMessage message;
  final bool isMe;

  const ChatBubble({required this.message, required this.isMe});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.all(4.0),
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: isMe ? Colors.blue : Colors.grey[300],
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(isMe ? 16.0 : 0.0),
              topRight: Radius.circular(isMe ? 0.0 : 16.0),
              bottomLeft: Radius.circular(16.0),
              bottomRight: Radius.circular(16.0),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                message.text,
                style: TextStyle(color: isMe ? Colors.white : Colors.black),
              ),
              SizedBox(height: 4.0),
              Text(
                message.time.toString(),
                style: TextStyle(fontSize: 12.0, color: Colors.grey),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
