import 'package:flutter/foundation.dart';
import 'package:fun_adventure/cores/models/user_app_data/user_app_data.dart';
import 'package:hive/hive.dart';

import '../../constants.dart';

Future<void> saveUserAppData(UserAppData? userData) async {
  print('userData == null ${userData == null}');
  try {
    final box = await Hive.openBox<UserAppData>(userBox);
    print('box.isOpen : ${box.isOpen}');
    print(userData?.userInfoData.uid);
    await box.put(userDataKey, userData!); // save it in hive
    box.close();
  } catch (e) {
    if (kDebugMode) {
      print(e.toString());
    }
  }
}
