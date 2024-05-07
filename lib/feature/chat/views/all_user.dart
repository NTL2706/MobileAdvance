// ignore_for_file: unnecessary_null_comparison

import 'package:final_project_advanced_mobile/feature/auth/provider/authenticate_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './chat_message.dart';
import '../provider/chat_provider.dart';
import '../utils/Image.dart';

class MessageWidget extends StatefulWidget {
  const MessageWidget({super.key});

  @override
  State<MessageWidget> createState() => _MessageWidgetState();
}

class _MessageWidgetState extends State<MessageWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: context.read<ChatProvider>().fetchDataAllChat(
              token:
                  context.read<AuthenticateProvider>().authenRepository.token!),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
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
                        prefixIcon: const Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                      child: ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(30.0), // Bo góc ở trên
                      bottom: Radius.circular(30.0), // Bo góc ở dưới
                    ),
                    child: Container(
                      color: Colors.grey[200],
                      child: ListView.builder(
                        itemCount: snapshot.data?.length.toInt() ??
                            0, // Replace this with your actual data count
                        itemBuilder: (context, index) {
                          return Padding(
                              padding: EdgeInsets.only(top: 12, bottom: 12),
                              child: ListTile(
                                leading: Container(
                                    width:
                                        55, // Kích thước mặc định bạn muốn đặt
                                    height: 55,
                                    child: const CircleAvatar(
                                      backgroundImage: AssetImage(
                                          'assets/images/avatar.png'),
                                    )),
                                title: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      snapshot.data?[index].sender.id ==
                                              context
                                                  .read<AuthenticateProvider>()
                                                  .authenRepository
                                                  .id
                                          ? snapshot
                                              .data![index].receiver.fullname
                                          : snapshot
                                              .data![index].sender.fullname,
                                    ),
                                    Text(
                                      snapshot.data![index].project.title,
                                      style: TextStyle(
                                          color: Colors.redAccent,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      snapshot.data![index].content,
                                      style: TextStyle(color: Colors.black38),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                                onTap: () async {
                                  final rs = await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ChatScreen(
                                              nameReceiver: snapshot
                                                          .data![index]
                                                          .sender
                                                          .id ==
                                                      context
                                                          .read<
                                                              AuthenticateProvider>()
                                                          .authenRepository
                                                          .id
                                                  ? snapshot.data![index]
                                                      .receiver.fullname
                                                  : snapshot.data![index].sender
                                                      .fullname,
                                              projectId: snapshot
                                                  .data![index].project.id,
                                              receiveId: snapshot.data?[index]
                                                          .sender.id ==
                                                      context
                                                          .read<
                                                              AuthenticateProvider>()
                                                          .authenRepository
                                                          .id
                                                  ? snapshot
                                                      .data![index].receiver.id
                                                  : snapshot
                                                      .data![index].sender.id,
                                            )), // Điều hướng đến màn hình chat
                                  );
                                  if (rs) {
                                    setState(() {});
                                  }
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
