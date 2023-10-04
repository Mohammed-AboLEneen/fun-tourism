import 'package:fun_adventure/cores/models/user_app_data/user_app_data.dart';

import '../../constants.dart';

void setupUserDataLocator(UserAppData user) {
  locator.registerSingleton<UserAppData>(user);
}
