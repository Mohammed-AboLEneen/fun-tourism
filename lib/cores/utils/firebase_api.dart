import 'package:firebase_messaging/firebase_messaging.dart';

Future<void> handleBackgroundNotificaitions(RemoteMessage message) async {
  print('this is Background notification');

  print('title : ${message.notification?.title}');
  print('body : ${message.notification?.body}');
  print('p : ${message.data}');
}

Future<void> handleTerminateNotificaitions(RemoteMessage message) async {
  print('this is Terminate notification');

  print('title : ${message.notification?.title}');
  print('body : ${message.notification?.body}');
  print('p : ${message.data}');
}

Future<void> handleRealNotificaitions(RemoteMessage message) async {
  print('this is real notification');
  print('title : ${message.notification?.title}');
  print('body : ${message.notification?.body}');
  print('p : ${message.data}');
}

class FirebaseApi {
  final _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initPushNotifications() async {
    FirebaseMessaging.instance.getInitialMessage().then((value) =>
        handleBackgroundNotificaitions); // when app opened form notification

    // when a user presses a notification message displayed
    FirebaseMessaging.onMessageOpenedApp.listen(handleBackgroundNotificaitions);
    FirebaseMessaging.onBackgroundMessage(handleBackgroundNotificaitions);
    FirebaseMessaging.onMessage.listen(handleRealNotificaitions);
  }

  Future<void> initNotifications() async {
    await _firebaseMessaging.requestPermission();

    String? token = await _firebaseMessaging.getToken();
    print('token : ${token}');
    await initPushNotifications();
  }
}
