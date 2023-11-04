import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../models/notification_model.dart';
import 'locator_manger.dart';

Future<void> handleBackgroundNotificaitions(RemoteMessage message) async {
  print('this is Background notification');
  LocatorManager.locator<FirebaseApi>().notification.value.title =
      message.notification?.title ?? 'Nothing to';
}

Future<void> handleTerminateNotificaitions(RemoteMessage message) async {
  print('this is Terminate notification');
  LocatorManager.locator<FirebaseApi>().notification.value.title =
      message.notification?.title ?? 'Nothing to';
}

Future<void> handleRealNotificaitions(RemoteMessage message) async {
  print('this is real notification');

  LocatorManager.locator<FirebaseApi>().notification.value =
      NotificationModel.fromNotification(
          notificationBody: message.notification?.body ?? 'nothing',
          notificationTitle: message.notification?.title ?? 'Nothing to',
          notData: message.data);
}

class FirebaseApi {
  final _firebaseMessaging = FirebaseMessaging.instance;
  ValueNotifier<NotificationModel> notification =
      ValueNotifier<NotificationModel>(NotificationModel());

  ValueNotifier<bool> initIsFinished = ValueNotifier<bool>(false);

  Future<void> initNotifications() async {
    await _firebaseMessaging.requestPermission();
    String? token = await _firebaseMessaging.getToken();
    print('token : ${token}');
    await initPushNotifications();
    initIsFinished.value = true;
  }

  final androidChannel = const AndroidNotificationChannel(
      'high_importance_channel', 'High_Importance_Notification',
      description: 'this is important notifications',
      importance: Importance.defaultImportance);

  final _localNotification = FlutterLocalNotificationsPlugin();

  Future<void> initLocalNotifications() async {
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    const settings = InitializationSettings(android: android);

    await _localNotification.initialize(settings,
        onDidReceiveNotificationResponse: (payload) {
      if (payload.payload == null) return;

      final message = RemoteMessage.fromMap(jsonDecode(payload.payload!));
      print(
          'get the notification is gogggggggggggggggggggggod : ${message.notification?.title}');
    });
  }

  Future<void> initPushNotifications() async {
    FirebaseMessaging.instance.getInitialMessage().then((value) =>
        handleBackgroundNotificaitions); // when app opened form notification

    // when a user presses a notification message displayed
    FirebaseMessaging.onMessageOpenedApp.listen(handleBackgroundNotificaitions);
    FirebaseMessaging.onBackgroundMessage(handleBackgroundNotificaitions);
    FirebaseMessaging.onMessage.listen((message) {
      final messageNotification = message.notification;

      if (messageNotification == null) return;

      print('this sis ifhsfsif ${message.data['imgeUrl']}');

      LocatorManager.locator<FirebaseApi>().notification.value =
          NotificationModel.fromNotification(
              notificationBody: message.notification?.body ?? 'nothing',
              notificationTitle: message.notification?.title ?? 'Nothing to',
              notData: message.data);

      _localNotification.show(
          message.hashCode,
          messageNotification.title,
          messageNotification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              androidChannel.id,
              androidChannel.name,
              channelDescription: androidChannel.description,
              icon: '@mipmap/ic_launcher',
            ),
          ),
          payload: jsonEncode(message.toMap()));
    });
  }
}
