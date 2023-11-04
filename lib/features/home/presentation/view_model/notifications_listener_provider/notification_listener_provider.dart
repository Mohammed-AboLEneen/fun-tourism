import 'package:flutter/cupertino.dart';
import 'package:fun_adventure/cores/utils/locator_manger.dart';
import 'package:fun_adventure/features/home/presentation/view_model/main_screen_cubit/main_screen_cubit.dart';

import '../../../../../cores/utils/firebase_api.dart';

class NotificationListenerProvider extends ChangeNotifier {
  int notificationsNumber = 0;

  void initNotificationsListener() {
    LocatorManager.locator<FirebaseApi>().notification.addListener(() {
      LocatorManager.locator<AppMainScreenCubit>()
          .userNotifications
          .insert(0, LocatorManager.locator<FirebaseApi>().notification.value);

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
