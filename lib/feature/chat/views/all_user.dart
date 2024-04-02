// ignore_for_file: unnecessary_null_comparison

import 'package:final_project_advanced_mobile/feature/chat/constants/chat_type.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './chat_message.dart';
import '../provider/chat_provider.dart';
import '../utils/Image.dart';

class MessageWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ChatProvider>(context);

    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          Expanded(
              child: ClipRRect(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(30.0), // Bo góc ở trên
              bottom: Radius.circular(30.0), // Bo góc ở dưới
            ),
            child: Container(
              color: Colors.grey[200],
              child: ListView.builder(
                itemCount: provider.chatusers
                    .length, // Replace this with your actual data count
                itemBuilder: (context, index) {
                  return Padding(
                      padding: EdgeInsets.only(top: 12, bottom: 12),
                      child: ListTile(
                        leading: Container(
                          width: 55, // Kích thước mặc định bạn muốn đặt
                          height: 55,
                          child: provider.chatusers[index].avatar != null
                              ? CustomImage(
                                  imageUrl: provider.chatusers[index].avatar,
                                  borderRadius: BorderRadius.circular(50),
                                )
                              : Icon(
                                  Icons.person,
                                  size: 55,
                                ),
                        ),
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(provider.chatusers[index].name), // User name
                            Text(
                              provider.chatusers[index].role,
                              style: TextStyle(
                                  color: Colors.redAccent,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  provider.chatusers[index].message[0],
                                  style: TextStyle(color: Colors.black38),
                                ),
                                if (provider.chatusers[index].seen == true)
                                  Icon(
                                    Icons.circle,
                                    size: 10,
                                    color: Colors.green,
                                  )
                              ],
                            ),

                            // Last message
                            // Time of last message
                          ],
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ChatScreen(
                                    chatUser: provider.chatusers[
                                        index])), // Điều hướng đến màn hình chat
                          );
                          // Handle tapping on the message
                        },
                      ));
                },
              ),
            ),
          )),
          SizedBox(height: 12),
        ],
      ),
    );
  }
}

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ChatProvider(),
      child: MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            scrolledUnderElevation: 0,
            title: Text('Chat Users'),
          ),
          body: MessageWidget(), // Display the ChatUserListWidget
        ),
      ),
    ),
  );
}
