class ChatScreenItemModel {
  late String name;
  late String lastMessageTime;
  late String lastMessageContent;
  late String chatItemImageUrl;
  late int numberOfNewMessages;

  ChatScreenItemModel();

  ChatScreenItemModel.fromJson(Map<String, dynamic> json) {
    name = json["name"];
    lastMessageTime = json["lastMessageTime"];
    lastMessageContent = json["lastMessageContent"];
    chatItemImageUrl = json["chatItemImageUrl"];
  }
}
