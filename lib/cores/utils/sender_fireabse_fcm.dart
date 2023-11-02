import 'dart:convert';

import 'package:http/http.dart' as http;

class FirebaseFcmApi {
  Future<void> sendFcm(String fcmTitle, String fcmBody,
      String receiverFcmToken) async {
    const postUrl = 'https://fcm.googleapis.com/fcm/send';
    final data = {
      "notification": {"body": fcmBody, "title": fcmTitle},
      "priority": "high",
      "data": {
        "click_action": "FLUTTER_NOTIFICATION_CLICK",
        "id": "1",
        "status": "done"
      },
      "to": receiverFcmToken
    };

    final headers = {
      'content-type': 'application/json',
      'Authorization': 'key=<YOUR_SERVER_KEY>'
    };

    final response = await http.post(Uri.parse(postUrl),
        body: json.encode(data),
        headers: headers);

    if (response.statusCode == 200) {
      print('message sent');
    } else {
      print('message not sent');
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
    }
  }
}
