// run this command to build this file flutter packages pub run build_runner build

class UserInfoData {
  String? email;
  String? displayName;
  String? photoURL;
  String? phoneNumber;
  String? uid;
  String? userTopic;
  String? createdIn;

  UserInfoData();

  // for get user data when sign in with google or with email & password
  UserInfoData.getAnonymousUserData(
      {required dynamic user, String? userEmail}) {
    email = userEmail;
    displayName = user?.displayName;
    photoURL = user?.photoURL;
    phoneNumber = user?.phoneNumber;
    uid = user?.uid;
  }

  UserInfoData.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    phoneNumber = json['phoneNumber'];
    displayName = json['displayName'];
    photoURL = json['photoURL'] ?? '';
    createdIn = json['created in'] ?? '';
  }
}
