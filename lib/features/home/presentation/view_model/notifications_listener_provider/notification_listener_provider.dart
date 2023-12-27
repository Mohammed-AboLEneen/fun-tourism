import 'package:flutter/material.dart';
import 'package:fun_adventure/cores/utils/locator_manger.dart';
import 'package:fun_adventure/features/home/presentation/view_model/main_screen_cubit/main_screen_cubit.dart';

import '../../../../../cores/utils/firebase_api.dart';

// this provider responsible for listen and add fcm notifications to userNotifications list in AppMainScreenCubit
class NotificationListenerProvider extends ChangeNotifier {
  int notificationsNumber = 0;

  void initNotificationsListener(context) {
    LocatorManager.locator<FirebaseApi>().notification.addListener(() {
      incrementNotificationsNumber();
      LocatorManager.locator<AppMainScreenCubit>()
          .userNotifications
          ?.insert(0, LocatorManager.locator<FirebaseApi>().notification.value);

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
