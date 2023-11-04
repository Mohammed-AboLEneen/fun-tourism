import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

import 'firestore_service.dart';

class FirebaseFcmSender {
  static int messageId = 1;

  static Future<void> sendFCMMessage(
      String serverKey, String fcmToken, String title, String body) async {
    final Dio dio = Dio();
    const String url = 'https://fcm.googleapis.com/fcm/send';

    DateTime now = DateTime.now();
    String formattedTime = DateFormat('HH:mm').format(now);

    final Map<String, dynamic> notification = {'body': body, 'title': title};

    final Map<String, dynamic> data = {
      "type": "f",
      "contentId": "notification",
      "time": formattedTime,
      "imageUrl":
          "https://th.bing.com/th/id/R.0b7bb2deb7735e7d9d55240d9d75afe8?rik=6dSZzezsXTVR2w&riu=http%3a%2f%2fs1.picswalls.com%2fwallpapers%2f2015%2f09%2f27%2fdragon-ball-z-hd-wallpaper_125243743_276.jpg&ehk=Otx7HLQDK%2bgr66sjRlJFESBG%2bGmu5yAOxInOoWq0Nvc%3d&risl=&pid=ImgRaw&r=0",
      'id': messageId,
      'status': 'done'
    };

    final Map<String, dynamic> fcmMessage = {
      'to': fcmToken,
      'notification': notification,
      'priority': 'high',
      'data': data
    };

    try {
      Response response = await dio.post(
        url,
        data: fcmMessage,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'key=$serverKey',
          },
        ),
      );

      messageId++;
    } catch (e) {
      print('error saving FCM message: $e');
    }

    try {
      FireStoreServices.saveNewNotification(fcmMessage);
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }
}
