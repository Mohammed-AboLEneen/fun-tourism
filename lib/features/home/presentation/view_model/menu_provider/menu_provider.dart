import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MenuProvider extends ChangeNotifier {
  String? selectedItemTitle;

  List<String> listTitles1 = [
    'Profile',
    'Friends',
    'Support',
    'Settings',
  ];

  List<String> listTitles2 = ['History', 'Notifications'];

  List<IconData> listIcons1 = [
    FontAwesomeIcons.user,
    FontAwesomeIcons.userGroup,
    FontAwesomeIcons.envelope,
    FontAwesomeIcons.gear
  ];

  List<IconData> listIcons2 = [
    Icons.history,
    Icons.notification_important,
  ];

  void changeSelectedIndex(String newSelectedItemTitle) {
    selectedItemTitle = newSelectedItemTitle;
    notifyListeners();
  }
}
