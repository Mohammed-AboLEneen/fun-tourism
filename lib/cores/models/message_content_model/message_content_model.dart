import 'package:hive/hive.dart';

part 'message_content_model.g.dart';

@HiveType(typeId: 4)
class MessageContentModel extends HiveObject {
  @HiveField(0)
  String? time;
  @HiveField(1)
  String? message;
  @HiveField(2)
  String? receiverId;
  @HiveField(3)
  String? senderId;

  MessageContentModel();

  MessageContentModel.fromJson(Map<String, dynamic> json) {
    time = json['time'];
    message = json['message'];
    receiverId = json['receiverId'];
    senderId = json['senderId'];
  }


}
