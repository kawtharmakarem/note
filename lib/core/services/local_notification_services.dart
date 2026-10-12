import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'dart:async';

import 'package:timezone/timezone.dart' as tz;

class LocalNotificationServices {
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  static StreamController<NotificationResponse> streamController =
      StreamController.broadcast();

  static void onTap(NotificationResponse notificationResponse) {
    streamController.add(notificationResponse);
  }

  static Future<void> init() async {
    InitializationSettings settings = InitializationSettings(
      android: AndroidInitializationSettings("@mipmap/ic_launcher"),
      iOS: DarwinInitializationSettings(),
    );
    await flutterLocalNotificationsPlugin.initialize(
      onDidReceiveBackgroundNotificationResponse: onTap,
      onDidReceiveNotificationResponse: onTap,
      settings: settings,
    );
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.requestNotificationsPermission();
  }

  static Future<void> showBasicNotification({
    required String title,
    required String content,
  }) async {
    NotificationDetails details = NotificationDetails(
      android: AndroidNotificationDetails(
        "id 1",
        "BasicNotification",
        importance: Importance.max,
        priority: Priority.high,
        sound: RawResourceAndroidNotificationSound(
          "sample3.m4a".split('.').first,
        ),
      ),
    );
    await flutterLocalNotificationsPlugin.show(
      id: 0,
      title: title,
      body: content,
      notificationDetails: details,

      payload: "PayloadData",
    );
  }

  static Future<void> showRepeatedNotification({
    required String title,
    required String content,
  }) async {
    NotificationDetails details = NotificationDetails(
      android: AndroidNotificationDetails(
        "id 2",
        "RepeatedNotification",
        importance: Importance.max,
        priority: Priority.high,
        sound: RawResourceAndroidNotificationSound(
          "sample3.m4a".split('.').first,
        ),
      ),
    );
    await flutterLocalNotificationsPlugin.periodicallyShow(
      id: 1,
      title: title,
      body: content,
      notificationDetails: details,
      repeatInterval: RepeatInterval.daily,
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
      payload: "payload",
    );
  }

  static Future<void> showScheduledNotification({
    required int id,
    required String title,
    required String content,
    required DateTime scheduledDateTime,
  }) async {
    NotificationDetails details = NotificationDetails(
      android: AndroidNotificationDetails(
        "id 3",
        "ScheduledNotification",
        importance: Importance.max,
        priority: Priority.high,
        enableLights: true,

        sound: RawResourceAndroidNotificationSound(
          "sample3.m4a".split('.').first,
        ),
      ),
    );
    await flutterLocalNotificationsPlugin.zonedSchedule(
      id: id,
      title: title,
      body: content,
      scheduledDate: tz.TZDateTime.from(scheduledDateTime, tz.local),
      notificationDetails: details,
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,

      payload: "$title\n$content",
    );
  }
}
