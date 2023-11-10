import 'package:hive/hive.dart';

// run this command to build this file flutter packages pub run build_runner build

class UserInfoData extends HiveObject {
  String? email;
  String? displayName;
  String? photoURL;
  String? phoneNumber;
  String? uid;
  String? userTopic;

  UserInfoData();

  UserInfoData.getAnonymousUserData(
      {required dynamic user, String? userEmail}) {
    email = userEmail;
    displayName = user?.displayName;
    photoURL = user?.photoURL;
    phoneNumber = user?.phoneNumber;
    uid = user?.uid;
  }
}
