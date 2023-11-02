import 'notification_data.dart';

class NotificationModel {
  String body = '';
  String title = '';

  NotificationData notificationData = NotificationData();

  NotificationModel();

  NotificationModel.fromNotification(
      {required String notificationTitle,
      required String notificationBody,
      required Map<String, dynamic> notData}) {
    body = notificationBody;
    title = notificationTitle;
    notificationData = NotificationData.fromJson(notData);

    print('title : $title');
    print('body : $body');
    print('data : ${notificationData.contentId}');
  }
}
