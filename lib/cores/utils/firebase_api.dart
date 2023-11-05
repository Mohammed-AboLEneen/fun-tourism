import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import '../models/notification_model.dart';
import 'locator_manger.dart';
import 'notification_services.dart';

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

  Future<void> initNotifications() async {
    await _firebaseMessaging.requestPermission();
    String? token = await _firebaseMessaging.getToken();
    print('token : ${token}');
    await initPushNotifications();
  }

  Future<void> initPushNotifications() async {
    FirebaseMessaging.instance.getInitialMessage().then((value) =>
        handleBackgroundNotificaitions); // when app opened form notification

    await NotificationService.initNotification();

    FirebaseMessaging.onMessageOpenedApp.listen(handleBackgroundNotificaitions);
    FirebaseMessaging.onBackgroundMessage(handleBackgroundNotificaitions);
    FirebaseMessaging.onMessage.listen((message) {
      final messageNotification = message.notification;

      if (messageNotification == null) return;

      NotificationService.showNotification(
        title: message.notification?.title,
        body: message.notification?.body,
      );
    });
  }
}
