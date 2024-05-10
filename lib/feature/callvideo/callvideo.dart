// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'package:final_project_advanced_mobile/feature/dashboard/providers/JobNotifier.dart';
import 'package:final_project_advanced_mobile/feature/notification/provider/notify_provider.dart';
import 'package:final_project_advanced_mobile/main.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'package:http/http.dart' as http;

Future deleteSchedule({
  required String token,
  required int interviewId,
}) async {
  String? baseUrl = env.apiURL;
  String endpoint = 'api/interview/$interviewId';

  try {
    final response = await http.delete(
      Uri.parse('$baseUrl$endpoint'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      print('Message sent successfully');
    } else {
      print('Failed to send message. Status code: ${response.statusCode}');
    }
  } catch (e) {
    print('Error while sending message: $e');
  }
}

class CallPage extends StatelessWidget {
  const CallPage(
      {Key? key,
      required this.token,
      required this.interviewId,
      required this.callID,
      required this.userId,
      required this.userName})
      : super(key: key);

  final String callID;
  final String userId;
  final String userName;
  final int interviewId;
  final String token;

  @override
  Widget build(BuildContext context) {
    return ZegoUIKitPrebuiltCall(
      events: ZegoUIKitPrebuiltCallEvents(
        onCallEnd: (ZegoCallEndEvent event, VoidCallback defaultAction) async {
          await deleteSchedule(token: token, interviewId: interviewId);
          context.read<NotiProvider>().reload();
          context.read<JobNotifier>().refresh();
          defaultAction.call();
        },
      ),
      appID:
          560044437, // Fill in the appID that you get from ZEGOCLOUD Admin Console.
      appSign:
          "26d09304d600e54bac18797654611bf1ef0a00daac4dabf37eabefc7d238cbcd", // Fill in the appSign that you get from ZEGOCLOUD Admin Console.
      userID: userId,
      userName: userName,
      callID: callID,
      // You can also use groupVideo/groupVoice/oneOnOneVoice to make more types of calls.
      config: ZegoUIKitPrebuiltCallConfig
          .oneOnOneVideoCall(), // Fill in the call type you want to make.
    );
  }
}
