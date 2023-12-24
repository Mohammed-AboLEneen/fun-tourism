import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:fun_adventure/main.dart';

import '../../features/home/presentation/view/widgets/home_screen_widgets/pages/profile_screen/profile_screen.dart';
import '../models/notification_model/notification_model.dart';
import 'locator_manger.dart';
import 'notification_services.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  final messageNotification = message.notification;
  print('this is packdoadjoad');
  if (messageNotification == null) return;
  LocatorManager.locator<FirebaseApi>().notification.value =
      NotificationModel.fromNotification(
          notificationBody: messageNotification.body ?? 'nothing',
          notificationTitle: messageNotification.title ?? 'Nothing to',
          notData: message.data);

  Future.delayed(const Duration(seconds: 7), () {
    navigatorKey.currentState?.push(PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 500),
        reverseTransitionDuration: const Duration(milliseconds: 500),
        pageBuilder: (context, animation, secondaryAnimation) =>
            const ProfileScreen(
              showLoadingIndicator: true,
            ),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          var begin = const Offset(0.0, 1.0);
          var end = Offset.zero;
          var tween = Tween(begin: begin, end: end);
          var offsetAnimation = animation.drive(tween);

          return SlideTransition(
            position: offsetAnimation,
            child: child,
          );
        },
        settings: RouteSettings(arguments: message.data['contentId'])));
  });
}

class FirebaseApi {
  final _firebaseMessaging = FirebaseMessaging.instance;
  ValueNotifier<NotificationModel> notification =
      ValueNotifier<NotificationModel>(NotificationModel());

  int notificationHashCode = 0;

  ValueNotifier<bool> initIsFinished = ValueNotifier<bool>(false);

  Future<void> initNotifications() async {
    await _firebaseMessaging.requestPermission();
    await initPushNotifications();
    initIsFinished.value = true;
  }

  Future<void> initPushNotifications() async {
    // when a user presses a notification message displayed

    FirebaseMessaging.instance.getInitialMessage().then((value) =>
        _firebaseMessagingBackgroundHandler); // when app opened form notification

    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      final messageNotification = message.notification;
      LocatorManager.locator<FirebaseApi>().notification.value =
          NotificationModel.fromNotification(
              notificationBody: messageNotification?.body ?? 'nothing',
              notificationTitle: messageNotification?.title ?? 'Nothing to',
              notData: message.data);

      if (message.data['type'] == 'f') {
        navigatorKey.currentState?.push(PageRouteBuilder(
            transitionDuration: const Duration(milliseconds: 500),
            reverseTransitionDuration: const Duration(milliseconds: 500),
            pageBuilder: (context, animation, secondaryAnimation) =>
                const ProfileScreen(
                  showLoadingIndicator: true,
                ),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              var begin = const Offset(0.0, 1.0);
              var end = Offset.zero;
              var tween = Tween(begin: begin, end: end);
              var offsetAnimation = animation.drive(tween);

              return SlideTransition(
                position: offsetAnimation,
                child: child,
              );
            },
            settings: RouteSettings(arguments: message.data['contentId'])));
      }
    });

    FirebaseMessaging.onMessage.listen((message) {
      final messageNotification = message.notification;

      if (messageNotification == null) return;

      notificationHashCode = messageNotification.hashCode;

      LocatorManager.locator<FirebaseApi>().notification.value =
          NotificationModel.fromNotification(
              notificationBody: messageNotification.body ?? 'nothing',
              notificationTitle: messageNotification.title ?? 'Nothing to',
              notData: message.data);

      NotificationService.showNotification(
          title: messageNotification.title,
          body: messageNotification.body,
          id: messageNotification.hashCode);
    });
  }
}
