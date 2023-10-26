import 'package:fun_adventure/cores/models/user_data_info/user_info_data.dart';
import 'package:hive/hive.dart';

part 'user_app_data.g.dart';

@HiveType(typeId: 1)
class UserAppData {
  @HiveField(0)
  UserInfoData userInfoData = UserInfoData();
  @HiveField(1)
  List<dynamic>? friends;
  @HiveField(2)
  List<dynamic>? chats;

  UserAppData();

  UserAppData.fromJson(Map<String, dynamic> json) {
    userInfoData.email = json['email'];

    userInfoData.phoneNumber = json['phoneNumber'];
    userInfoData.displayName = json['displayName'];
    userInfoData.photoURL = json['photoURL'];
    friends = json['friends'];
    chats = json['chats'];
  }
}
