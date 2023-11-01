class NotificationModel {

  late String contentId;
  late String body;
  late String title;
  late String imageUrl;

  NotificationModel();

  NotificationModel.fromJson(Map<String, dynamic> json){
    contentId = json['contentId'];
    body = json['body'];
    title = json['title'];
    imageUrl = json['imageUrl'];
  }
}