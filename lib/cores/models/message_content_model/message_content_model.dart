import 'package:hive/hive.dart';

part 'message_content_model.g.dart';

@HiveType(typeId: 4)
class MessageContentModel extends HiveObject {
  @HiveField(0)
  String? sendMessageTime;
  @HiveField(1)
  String? message;
  @HiveField(2)
  String? receiverId;
  @HiveField(3)
  String? senderId;
  @HiveField(4)
  bool? isSend;

  MessageContentModel();

  MessageContentModel.fromJson(Map<String, dynamic>? json) {
    sendMessageTime = json?['sendMessageTime'];
    message = json?['message'];
    receiverId = json?['receiverId'];
    senderId = json?['senderId'];
  }
}
