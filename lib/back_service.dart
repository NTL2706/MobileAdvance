import 'dart:async';
import 'dart:ui';

import 'package:final_project_advanced_mobile/local_notification.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_background_service_android/flutter_background_service_android.dart';


Future<void> initializeService() async {
  final service = FlutterBackgroundService();
  await service.configure(
    iosConfiguration: IosConfiguration(),
    androidConfiguration:
        AndroidConfiguration(
          
          onStart: onStart, isForegroundMode: true,autoStart: true),
  );
}

@pragma('vm:entry-point')
void onStart(ServiceInstance service) {
  DartPluginRegistrant.ensureInitialized();
  
  if (service is AndroidServiceInstance) { 
    service.on("setAsForeground").listen((event) {
      print("hello");
      service.setAsForegroundService();
    });
    service.on("setAsBackground").listen((event) {
      service.setAsBackgroundService();
    });
  }
  service.on("stopService").listen((event) {
    service.stopSelf();
  });

  Timer.periodic(Duration(seconds: 1), (timer)async {
    if (service is AndroidServiceInstance){
      if ((await service.isForegroundService())){
        LocalNotification.showSimpleNotification(
          body: "123",
          payload: "123",
          titile: "123"
        );
      print(await service.isForegroundService()); 
        service.setForegroundNotificationInfo(title: "Script academy", content: "sub my channel");
      }
    }
    print('background service running');
    service.invoke("update");
  });
}
