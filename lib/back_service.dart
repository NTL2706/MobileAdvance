import 'dart:async';
import 'dart:ui';
import 'package:final_project_advanced_mobile/constants/noti_type_flag.dart';
import 'package:final_project_advanced_mobile/main.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:final_project_advanced_mobile/feature/chat/constants/chat_type.dart';
import 'package:final_project_advanced_mobile/feature/chat/provider/chat_provider.dart';
import 'package:final_project_advanced_mobile/local_notification.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_background_service_android/flutter_background_service_android.dart';

Future<void> initializeService() async {
  final service = FlutterBackgroundService();
  await service.configure(
    iosConfiguration: IosConfiguration(),
    androidConfiguration: AndroidConfiguration(
        onStart: onStart, isForegroundMode: true, autoStart: true),
  );
}

@pragma('vm:entry-point')
void onStart(ServiceInstance service) {
  if (service is AndroidServiceInstance) {
    service.on("setAsForeground").listen((event) {
      print("foreground");
      String token = event?['token'];
      String userId = (event?['userId']).toString();
      SocketManager socketManager = SocketManager(token: token);

      socketManager.socket?.on("NOTI_$userId", (data) {
        print(data);
        print(data['notification']['typeNotifyFlag'].toString() == TypeNotifyFlag['Offer'].toString());
        if (data['notification']['typeNotifyFlag'].toString() == TypeNotifyFlag['Offer'].toString()) {
          LocalNotification.showSimpleNotification(
              titile: data['notification']['title'],
              body: data['notification']['content'],
              payload: "123");
        } else if (data['notification']['typeNotifyFlag'].toString() ==
            TypeNotifyFlag['Chat'].toString()) {
          LocalNotification.showSimpleNotification(
              titile: data['notification']['sender']['fullname'],
              body: data['notification']['message']['content'],
              payload: "123");
        }
      });

      service.setAsForegroundService();
    });

    service.on("setAsBackground").listen((event) {
      String token = event?['token'];
      String userId = (event?['userId']).toString();
      SocketManager socketManager = SocketManager(token: token);

      socketManager.socket?.on("NOTI_$userId", (data) async {
        print(data);
        if (data['notification']['typeNotifyFlag'] ==
            TypeNotifyFlag['Offer']) {}
        await LocalNotification.showSimpleNotification(
            titile: "123", body: "123", payload: "123");
      });
      service.setAsBackgroundService();
    });
  }

  service.on("stopService").listen((event) {
    service.stopSelf();
  });

  // Timer.periodic(Duration(seconds: 1), (timer)async {
  //   if (service is AndroidServiceInstance){
  //     if ((await service.isForegroundService())){
  //       LocalNotification.showSimpleNotification(
  //         body: "123",
  //         payload: "123",
  //         titile: "123"
  //       );
  //     print(await service.isForegroundService());
  //       service.setForegroundNotificationInfo(title: "Script academy", content: "sub my channel");
  //     }
  //   }
  //   print('background service running');
  //   service.invoke("update");
  // });
}
