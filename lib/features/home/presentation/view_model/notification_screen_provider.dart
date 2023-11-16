import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:fun_adventure/cores/models/notification_model/notification_model.dart';
import 'package:fun_adventure/cores/utils/firestore_service.dart';
import 'package:fun_adventure/cores/utils/locator_manger.dart';
import 'package:fun_adventure/features/home/presentation/view_model/main_screen_cubit/main_screen_cubit.dart';

class NotificationScreenProvider extends ChangeNotifier {
  Future<void> requestUserNotifications(BuildContext context) async {
    if (LocatorManager.locator<AppMainScreenCubit>()
        .userNotifications
        .isEmpty) {
      try {
        QuerySnapshot querySnapshot =
            await FireStoreServices.requestUserNotifications();
        List<NotificationModel> notifications = [];

        for (var element in querySnapshot.docs) {
          Map<String, dynamic> data = element.data() as Map<String, dynamic>;

          notifications.add(NotificationModel.fromNotification(
              notificationTitle: data['notification']['title'],
              notificationBody: data['notification']['body'],
              notData: data['data']));
        }

        LocatorManager.locator<AppMainScreenCubit>()
            .userNotifications
            .addAll(notifications.reversed);

        notifyListeners();
      } catch (e) {
        print(e.toString());
      }
    }
  }
}
