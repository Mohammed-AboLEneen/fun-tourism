import 'package:firebase_auth/firebase_auth.dart';
import 'package:fun_adventure/cores/utils/sheard_preferance_helper.dart';

import '../../constants.dart';
import '../utils/user_info_data.dart';

void setupUserLocator(User user) {
  locator.registerSingleton<UserInfoData>(
      UserInfoData.getAnonymousUserData(user: user));
}

void sharedPreferenceLocator() {
  locator.registerSingleton<SharedPreferenceHelper>(SharedPreferenceHelper());
}
