 import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class LocalNotification {
  static final FlutterLocalNotificationsPlugin
      _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  static Future init() async {
    // initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('drawable/flutter_logo');
    
    final DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      onDidReceiveLocalNotification: (id, title, body, payload) => null,
    );
    final LinuxInitializationSettings initializationSettingsLinux =
        LinuxInitializationSettings(defaultActionName: 'Open notification');
    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsDarwin,
            );
    await _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (details) => null,
    );
  }

  static Future showSimpleNotification(
      {required String titile,
      required String body,
      required String payload}) async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails('your channel id', 'your channel name',
            icon: '@mipmap/ic_launcher',
            channelDescription: 'your channel description',
            importance: Importance.max,
            priority: Priority.high,
            ticker: 'ticker');
    const NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);

    await _flutterLocalNotificationsPlugin
        .show(0, titile, body, notificationDetails, payload: payload);
  }

  static Future scheduleNotification(
      {required int id,
      required String title,
      required String body,
      required String payload,
      required DateTime scheduleDateTime}) async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails('your channel id', 'your channel name',
            icon: '@mipmap/ic_launcher',
            channelDescription: 'your channel description',
            importance: Importance.max,
            priority: Priority.high,
            ticker: 'ticker');

    
    const NotificationDetails notificationDetails =
        NotificationDetails(
          iOS: DarwinNotificationDetails(
            sound: 'default.wav',
            presentAlert: true,
            presentBadge: true,
            presentSound: true,
          ),
          android: androidNotificationDetails);

    tz.initializeTimeZones();

    final tz.TZDateTime scheduledAt = tz.TZDateTime.now(tz.getLocation("Asia/Ho_Chi_Minh")).add(Duration(seconds: 5));
    // tz.TZDateTime.from(scheduleDateTime, tz.getLocation("Asia/Ho_Chi_Minh"));
        // tz.TZDateTime.now(tz.getLocation("Asia/Ho_Chi_Minh"))
        //     .add(Duration(seconds: second));
    print(scheduledAt);
    await  _flutterLocalNotificationsPlugin.zonedSchedule(
        id, title, body, scheduledAt, notificationDetails,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        payload: payload);
  }
}