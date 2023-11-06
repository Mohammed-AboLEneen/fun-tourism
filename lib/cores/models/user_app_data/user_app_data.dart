import 'package:fun_adventure/cores/models/user_data_info/user_info_data.dart';

class UserAppData {
  UserInfoData userInfoData = UserInfoData();

  List<dynamic>? friends;

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
