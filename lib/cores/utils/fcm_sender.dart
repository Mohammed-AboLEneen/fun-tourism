import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

import '../../constants.dart';

class FirebaseFcmSender {
  static int messageId = 1;

  static Future<void> sendFCMMessage(
      String serverKey, String receiverId, String title, String body,
      {String? image}) async {
    final Dio dio = Dio();
    const String url = 'https://fcm.googleapis.com/fcm/send';
    String topic = '/topics/user_';

    DateTime now = DateTime.now();
    String formattedTime = DateFormat('HH:mm').format(now);

    final Map<String, dynamic> notification = {'body': body, 'title': title};

    final Map<String, dynamic> data = {
      "type": "f",
      "contentId": uId,
      "time": formattedTime,
      "imageUrl": image ??
          "https://th.bing.com/th/id/R.0b7bb2deb7735e7d9d55240d9d75afe8?rik=6dSZzezsXTVR2w&riu=http%3a%2f%2fs1.picswalls.com%2fwallpapers%2f2015%2f09%2f27%2fdragon-ball-z-hd-wallpaper_125243743_276.jpg&ehk=Otx7HLQDK%2bgr66sjRlJFESBG%2bGmu5yAOxInOoWq0Nvc%3d&risl=&pid=ImgRaw&r=0",
      'id': messageId,
      'status': 'done'
    };

    final Map<String, dynamic> fcmMessage = {
      'to': '$topic$receiverId',
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
      FirebaseFirestore.instance
          .collection('users')
          .doc(receiverId)
          .collection('notifications')
          .doc()
          .set(fcmMessage);
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }
}
