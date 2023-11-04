class NotificationData {
  String? contentId;
  String? imageUrl;
  String? type;
  String? time;

  NotificationData();

  NotificationData.fromJson(Map<String, dynamic> json) {
    contentId = json['contentId'];
    imageUrl = json['imageUrl'];
    type = json['type'];
    time = json['time'];
  }
}
