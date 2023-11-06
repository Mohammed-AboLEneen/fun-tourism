import 'package:flutter/cupertino.dart';
import 'package:fun_adventure/cores/utils/screen_dimentions.dart';

class NotificationsScreenUiManger {

  double notificationScreenHeight = 0;
  bool notificationScreenIsOpened = false;
  bool notificationScreenBodyVisible = false;


  void openNotificationScreen(BuildContext context) {
    notificationScreenIsOpened = true;
    changeNotificationsScreenHeight(context);
  }

  void closeNotificationScreen(BuildContext context) {
    setTheNotificationsScreenBodyVisibility(false);
    notificationScreenIsOpened = false;
    changeNotificationsScreenHeight(context);
  }

  void setTheNotificationsScreenBodyVisibility(bool state) {
    notificationScreenBodyVisible = state;
  }

  void changeNotificationsScreenHeight(BuildContext context) {
    notificationScreenHeight =
    notificationScreenIsOpened ? context.height * .75 : 0;
  }
}