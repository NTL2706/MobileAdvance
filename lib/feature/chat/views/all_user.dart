// ignore_for_file: unnecessary_null_comparison

import 'package:final_project_advanced_mobile/feature/auth/provider/authenticate_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './chat_message.dart';
import '../provider/chat_provider.dart';
import '../utils/Image.dart';

class MessageWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SocketManager socket = SocketManager(
      token: context.read<AuthenticateProvider>().authenRepository.token!,
      projectId: '1',
    );

    return Scaffold(
      body: FutureBuilder(
          future: context.read<ChatProvider>().fetchDataAllChat(
              token:
                  context.read<AuthenticateProvider>().authenRepository.token!),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                  child:
                      CircularProgressIndicator()); // Hiển thị spinner khi dữ liệu đang được tải
            } else if (snapshot.hasError) {
              return Text('Lỗi: ${snapshot.error}'); // Hiển thị lỗi nếu có
            } else {
              return Column(
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
                        itemCount: context
                            .watch<ChatProvider>()
                            .chatusers
                            .length, // Replace this with your actual data count
                        itemBuilder: (context, index) {
                          return Padding(
                              padding: EdgeInsets.only(top: 12, bottom: 12),
                              child: ListTile(
                                leading: Container(
                                  width: 55, // Kích thước mặc định bạn muốn đặt
                                  height: 55,
                                  child: context
                                              .read<ChatProvider>()
                                              .chatusers[index]
                                              .avatar !=
                                          null
                                      ? CustomImage(
                                          imageUrl: context
                                              .read<ChatProvider>()
                                              .chatusers[index]
                                              .avatar,
                                          borderRadius:
                                              BorderRadius.circular(50),
                                        )
                                      : Icon(
                                          Icons.person,
                                          size: 55,
                                        ),
                                ),
                                title: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(context
                                        .read<ChatProvider>()
                                        .chatusers[index]
                                        .name), // User name
                                    Text(
                                      context
                                          .read<ChatProvider>()
                                          .chatusers[index]
                                          .role,
                                      style: TextStyle(
                                          color: Colors.redAccent,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          context
                                              .read<ChatProvider>()
                                              .chatusers[index]
                                              .message[0],
                                          style:
                                              TextStyle(color: Colors.black38),
                                        ),
                                        if (context
                                                .read<ChatProvider>()
                                                .chatusers[index]
                                                .seen ==
                                            true)
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
                                            chatUser: context
                                                    .read<ChatProvider>()
                                                    .chatusers[
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
              );
            }
          }),
    );
  }
}
