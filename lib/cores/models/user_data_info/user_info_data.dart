import 'package:hive/hive.dart';

// run this command to build this file flutter packages pub run build_runner build

part 'user_info_data.g.dart';

@HiveType(typeId: 0)
class UserInfoData extends HiveObject {
  @HiveField(0)
  String? email;
  @HiveField(1)
  String? displayName;
  @HiveField(2)
  String? photoURL;
  @HiveField(3)
  String? phoneNumber;
  @HiveField(4)
  String? uid;

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
