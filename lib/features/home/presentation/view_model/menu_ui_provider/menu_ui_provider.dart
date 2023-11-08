import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fun_adventure/features/home/presentation/view_model/home_screen_cubit/home_screen_cubit.dart';

class MenuUIProvider extends ChangeNotifier {
  String? selectedItemTitle;

  List<String> listTitles1 = [
    'Home',
    'Profile',
    'Friends',
    'Support',
    'Settings',
  ];

  List<String> listTitles2 = ['History', 'Notifications'];

  List<IconData> listIcons1 = [
    FontAwesomeIcons.house,
    FontAwesomeIcons.user,
    FontAwesomeIcons.userGroup,
    FontAwesomeIcons.envelope,
    FontAwesomeIcons.gear
  ];

  List<IconData> listIcons2 = [
    Icons.history,
    Icons.notification_important,
  ];

  List<void Function()?> list1actions = [];
  List<void Function()?> list2actions = [];

  void initListsActions(context) {
    initList1Actions(context);
    initList2Actions(context);
    notifyListeners();
  }

  void initList1Actions(context) {
    list1actions.add(() => BlocProvider.of<HomeScreenCubit>(context)
        .changeTheCurrentHomeScreenPage(0));
    list1actions.add(() => BlocProvider.of<HomeScreenCubit>(context)
        .changeTheCurrentHomeScreenPage(1));
    list1actions.add(() => BlocProvider.of<HomeScreenCubit>(context)
        .changeTheCurrentHomeScreenPage(0));
    list1actions.add(() => BlocProvider.of<HomeScreenCubit>(context)
        .changeTheCurrentHomeScreenPage(1));
    list1actions.add(() => BlocProvider.of<HomeScreenCubit>(context)
        .changeTheCurrentHomeScreenPage(0));
  }

  void initList2Actions(context) {
    list2actions.add(() => BlocProvider.of<HomeScreenCubit>(context)
        .changeTheCurrentHomeScreenPage(0));
    list2actions.add(() => BlocProvider.of<HomeScreenCubit>(context)
        .changeTheCurrentHomeScreenPage(1));
  }

  void changeSelectedIndex(String newSelectedItemTitle) {
    selectedItemTitle = newSelectedItemTitle;
    notifyListeners();
  }
}
