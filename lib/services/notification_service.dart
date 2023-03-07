import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
    
  static Future<void> initNotifcations() async {
     final AndroidInitializationSettings androidInitializationSettings = AndroidInitializationSettings('app_icon');
     
     final InitializationSettings initializationSettings = InitializationSettings(
      android: androidInitializationSettings
     );
     await flutterLocalNotificationsPlugin.initialize(initializationSettings, onDidReceiveBackgroundNotificationResponse: notificationResponse);
  }

  static void notificationResponse(NotificationResponse response) async {
      const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
           "test", //Required for Android 8.0 or after
           "test", //Required for Android 8.0 or after
            channelDescription: "test",
            playSound: true, //Required for Android 8.0 or after
            importance: Importance.max,
            priority: Priority.high);
        
      const NotificationDetails details = NotificationDetails(android: androidPlatformChannelSpecifics);

      await flutterLocalNotificationsPlugin.show(
        0, "test", "test", details, payload : "data"
      );
  }

}