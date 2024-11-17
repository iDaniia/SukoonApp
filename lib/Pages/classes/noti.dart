import 'dart:core';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:sukoon/Pages/EEG_Session.dart';

class Noti {
  static FlutterLocalNotificationsPlugin flutterLocalNotifications =
      FlutterLocalNotificationsPlugin();
  static onPressed(NotificationResponse notificationResponse) {
    
  }
  static Future init() async {
    InitializationSettings settings = const InitializationSettings(
        android: AndroidInitializationSettings('@mipmap/notification'),
        iOS: DarwinInitializationSettings());
    flutterLocalNotificationsPlugin.initialize(settings,
        onDidReceiveBackgroundNotificationResponse: onPressed,
        onDidReceiveNotificationResponse: onPressed);
  }


// basic notification
  static  showNotification() async {
    NotificationDetails details = const NotificationDetails(
        android: AndroidNotificationDetails("id 1", "basic notification",
             importance: Importance.max, priority: Priority.high, ));
    await flutterLocalNotificationsPlugin.show(
        0, "Negative Emotion", "Result of EEG session is Negative", details,
        payload: "payloadS");
  }
  

}
