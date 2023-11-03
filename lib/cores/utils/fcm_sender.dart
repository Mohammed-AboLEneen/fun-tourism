import 'package:dio/dio.dart';

class FirebaseFcmSender {


  static int messageId = 1;

  static Future<void> sendFCMMessage(String serverKey, String fcmToken,
      String title,
      String body) async {
    final Dio dio = Dio();
    const String url = 'https://fcm.googleapis.com/fcm/send';

    final Map<String, dynamic> notification = {
      'body': body,
      'title': title
    };

    final Map<String, dynamic> data = {
      'click_action': 'FLUTTER_NOTIFICATION_CLICK',
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

      print('FCM response data: ${response.data}');
      print('FCM response status: ${response.statusCode}');
    } catch (e) {
      print('error sending FCM message: $e');
    }
  }

}