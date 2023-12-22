import 'notification_data.dart';

class NotificationModel {
  String body = '';
  String title = '';
  int index = 0;

  late NotificationData notificationData;

  NotificationModel();

  NotificationModel.fromNotification(
      {required String notificationTitle,
      required String notificationBody,
      required Map<String, dynamic> notData}) {
    body = notificationBody;
    title = notificationTitle;
    notificationData = NotificationData.fromJson(notData);
  }
}
