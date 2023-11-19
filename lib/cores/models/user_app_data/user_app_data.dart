import 'package:fun_adventure/cores/models/user_data_info/user_info_data.dart';

class UserAppData {
  UserInfoData userInfoData = UserInfoData();
  List<dynamic>? chats;

  UserAppData();

  UserAppData.fromJson(Map<String, dynamic> json) {
    userInfoData = UserInfoData.fromJson(json);
    chats = json['chats'];
  }
}
