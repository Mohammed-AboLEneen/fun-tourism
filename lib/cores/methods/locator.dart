import 'package:fun_adventure/cores/utils/sheard_preferance_helper.dart';

import '../../constants.dart';
import '../models/user_data_info/user_info_data.dart';

void setupUserLocator(dynamic user) {
  locator.registerSingleton<UserInfoData>(
      UserInfoData.getAnonymousUserData(user: user));
}

void sharedPreferenceLocator() {
  locator.registerSingleton<SharedPreferenceHelper>(SharedPreferenceHelper());
}
