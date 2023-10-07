import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fun_adventure/cores/models/user_app_data/user_app_data.dart';
import 'package:fun_adventure/cores/utils/firestore_service.dart';
import 'package:fun_adventure/features/home/presentation/view/widgets/home_screen.dart';
import 'package:fun_adventure/features/home/presentation/view_model/home_cubit/app_main_screen_states.dart';
import 'package:hive/hive.dart';

import '../../../../../cores/methods/locator.dart';

class AppMainScreenCubit extends Cubit<AppMainScreenStates> {
  AppMainScreenCubit() : super(AppMainScreenInitState());

  late UserAppData userData;
  String userBox = 'userBox'; // name of hive box which hold user data.
  String userDataKey =
      'userAppDataKey'; // key of userAppData object in hive box.

  int currentIndex = 0;

  List<IconData> bottomNavigationBarIcons = [
    FontAwesomeIcons.house,
    FontAwesomeIcons.rocketchat,
    FontAwesomeIcons.magnifyingGlass,
    FontAwesomeIcons.plus,
  ];

  List<Widget> screens = [
    const HomeScreen(),
    const HomeScreen(),
    const HomeScreen(),
    const HomeScreen(),
  ];

  static AppMainScreenCubit get(context) => BlocProvider.of(context);

  Future<bool> checkIfUserDataSavedLocal() async {
    final box = await Hive.openBox<UserAppData>(userBox);
    return box.isEmpty;
  }

  Future<void> getUserData(String email) async {
    emit(GetUserDataLoadingState());

    try {
      DocumentSnapshot<Object?> data =
          await FireStoreServices.getUserData(email: email);
      userData = UserAppData.fromJson(data.data() as Map<String, dynamic>);

      await _saveUserAppData();

      emit(GetUserDataSuccessState());
    } catch (e) {
      print(e.toString());
      emit(GetUserDataFailureState(e.toString()));
    }
  }

  void changeBottomNavigationBarIndex(int index) {
    currentIndex = index;
    emit(ChangeBottomNavigationBarIndex());
  }

  Future<void> _saveUserAppData() async {
    final box = await Hive.openBox<UserAppData>(userBox);
    box.put(userDataKey, userData); // save it in hive
    setupUserDataLocator(userData); // save it in locator to use it in all app.
    box.close();
  }
}
