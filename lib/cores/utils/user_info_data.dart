import 'package:hive/hive.dart';

// run this command to build this file flutter packages pub run build_runner build
part 'user_info_data.g.dart';

@HiveType(typeId: 0)
class UserInfoData extends HiveObject {
  @HiveField(0)
  String? email;
  @HiveField(1)
  String? name;
  @HiveField(2)
  String? photoUrl;
  @HiveField(3)
  String? phoneNumber;
  @HiveField(4)
  String? _uid;

  UserInfoData();

  UserInfoData.getAnonymousUserData({required dynamic user}) {
    email = user?.displayName;
    name = user?.displayName;
    photoUrl = user?.photoURL;
    phoneNumber = user?.phoneNumber;
    _uid = user?.uid;
  }
}
