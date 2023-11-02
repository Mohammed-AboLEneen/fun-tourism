import 'package:flutter/cupertino.dart';
import 'package:fun_adventure/cores/utils/locator_manger.dart';

import '../../../../../cores/utils/firebase_api.dart';

class NotificationRedCircleProvider extends ChangeNotifier {
  late int notificationsNumber;


  void initNotificationsListener() {
    print('-------------------------------');
    LocatorManager
        .locator<FirebaseApi>()
        .notification
        .addListener(() {
      incrementNotificationsNumber();
      notifyListeners();
    });
  }

  void setNotificationsNumber(int count) {
    notificationsNumber = count;
    notifyListeners();
  }

  void incrementNotificationsNumber() {
    notificationsNumber++;
  }
}
