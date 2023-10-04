import 'package:hive/hive.dart';

part 'user_app_data.g.dart';

@HiveType(typeId: 1)
class UserAppData {
  @HiveField(0)
  String? email;
  @HiveField(1)
  String? phoneNumber;
  @HiveField(2)
  String? displayName;
  @HiveField(3)
  String? photoURL;
  @HiveField(4)
  List<Map<String, dynamic>>? friends;
  @HiveField(5)
  List<Map<String, dynamic>>? chats;

  UserAppData();

  UserAppData.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    phoneNumber = json['phoneNumber'];
    displayName = json['displayName'];
    photoURL = json['photoURL'];
    friends = json['friends'];
    chats = json['chats'];
  }
}
