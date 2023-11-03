import 'package:flutter/cupertino.dart';
import 'package:fun_adventure/cores/utils/locator_manger.dart';

import '../../../../../cores/utils/firebase_api.dart';

class NotificationProvider extends ChangeNotifier {
  int notificationsNumber = 0;

  void initNotificationsListener() {
    LocatorManager
        .locator<FirebaseApi>()
        .notification
        .addListener(() {
      incrementNotificationsNumber();
      notifyListeners();
    });
  }

  void setNotificationsNumber(int count) {
    print('its geeeeeeeet it');
    notificationsNumber = count;
    notifyListeners();
  }

  void incrementNotificationsNumber() {
    notificationsNumber++;
  }
}
