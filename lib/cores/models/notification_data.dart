class NotificationData {
  late String? contentId;
  late String? imageUrl;

  NotificationData();

  NotificationData.fromJson(Map<String, dynamic> json) {
    contentId = json['contentId'];
    imageUrl = json['imageUrl'];
  }
}
