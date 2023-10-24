import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fun_adventure/cores/methods/toast.dart';
import 'package:fun_adventure/cores/models/hot_travels_model/hot_travels_model.dart';
import 'package:fun_adventure/cores/models/recent_news_model/recent_news_model.dart';
import 'package:fun_adventure/cores/models/user_app_data/user_app_data.dart';
import 'package:fun_adventure/cores/utils/firestore_service.dart';
import 'package:fun_adventure/cores/utils/internet_connection.dart';
import 'package:fun_adventure/features/home/presentation/view/widgets/home_screen_widgets/t.dart';
import 'package:fun_adventure/features/home/presentation/view_model/home_cubit/app_main_screen_states.dart';
import 'package:hive/hive.dart';

import '../../../../../constants.dart';
import '../../../../../cores/methods/download_image.dart';
import '../../../../../cores/methods/save_home_screen.dart';
import '../../../../../cores/methods/save_user_data.dart';
import '../../../../../cores/utils/get_location.dart';
import '../../../../../cores/utils/wating_screen.dart';
import '../../view/home_screen.dart';

class AppMainScreenCubit extends Cubit<AppMainScreenStates> {
  AppMainScreenCubit() : super(AppMainScreenInitState());

  UserAppData? userData;
  int currentIndex = 0;
  InternetConnectionState internetConnection = InternetConnectionState();

  List<RecentNewsModel> recentNews = [];
  List<RecentNewsModel> recentNewsTemp = [];
  List<HotTravelModel> hotTravels = [];
  List<HotTravelModel> hotTravelsTemp = [];

  List<Widget> screens = [
    const HomeScreen(),
    const LolScreen(
      title: 'Welcome man',
    ),
    const WaitingScreen(),
    const HomeScreen(),
  ];

  UserLocation userLocation = UserLocation();

  static AppMainScreenCubit get(context) => BlocProvider.of(context);

  Future<void> blocOperations(String userEmail) async {
    // to access cubit from internetConnectionState.
    // init the variables that will read the state if the internet.
    await internetConnection.initConnectivity();

    await getUserLocation();
    initLocalAppData();

    getUserData(userEmail);
    getHomeScreen();
  }

  Future<void> initLocalAppData() async {
    try {
      final box1 = await Hive.openBox(hotTravelsBox);
      final box2 = await Hive.openBox(recentNewsBox);
      final box3 = await Hive.openBox<UserAppData>(userBox);

      hotTravels = box1.get(hotTravelsKey).cast<HotTravelModel>();
      recentNews = box2.get(recentNewsKey).cast<RecentNewsModel>();
      userData = box3.get(userDataKey) ?? UserAppData();

      // close all boxes when firebase data coming and update hive boxes values.
      await box1.close();
      await box2.close();
      emit(GetLocalAppDataSuccessState());
    } catch (e, x) {
      String msg = '';

      if (internetConnection.connectionStatus.name == 'none') {
        msg = 'There is no internet to get data !';
      } else {
        msg = 'There is no saved data, wait to get it';
      }

      showToast(msg: msg, bgColor: Colors.red, txColor: Colors.white);

      if (kDebugMode) {
        print(e.toString());
      }
      if (kDebugMode) {
        print(x);
      }
      emit(GetLocalAppDataFailureState());
    }
  }

  Future<void> getUserData(
    String email,
  ) async {
    if (internetConnection.connectionStatus.name != 'none') {
      emit(GetUserDataLoadingState());

      try {
        DocumentSnapshot<Object?> data =
            await FireStoreServices.getUserData(email: email);
        userData = UserAppData.fromJson(data.data() as Map<String, dynamic>);
        await saveUserAppData(userData);
        emit(GetUserDataSuccessState());
      } catch (e) {
        if (kDebugMode) {
          print(e.toString());
        }

        emit(GetUserDataFailureState(e.toString()));
      }
    } else {
      showToast(
          msg: 'Please turn on wifi or mobile data',
          bgColor: Colors.red,
          txColor: Colors.white);
    }
  }

  // this function is called when get the state of the internet,
  // so when open wifi or mobile after close it,
  // this function will be called again to get the new data.
  Future<void> getHomeScreen() async {
    if (internetConnection.connectionStatus.name != 'none') {
      try {
        hotTravelsTemp.addAll(hotTravels);
        recentNewsTemp.addAll(recentNews);
        hotTravels.clear();
        recentNews.clear();

        emit(GetHomeScreenDataLoadingState());

        DocumentSnapshot<Object?> data1 =
            await FireStoreServices.getHomeScreenData('last travels');
        DocumentSnapshot<Object?> data2 =
            await FireStoreServices.getHomeScreenData('recent news');

        Map<String, dynamic> dataList1 = data1.data() as Map<String, dynamic>;
        Map<String, dynamic> dataList2 = data2.data() as Map<String, dynamic>;

        for (Map<String, dynamic> element in dataList1.values.toList()) {
          element['image'] = await downloadAndStoreImage(element['image']);
          hotTravels.add(HotTravelModel.fromJson(element));
        }

        for (Map<String, dynamic> element in dataList2.values.toList()) {
          element['image'] = await downloadAndStoreImage(element['image']);
          recentNews.add(RecentNewsModel.fromJson(element));
        }

        saveHomeScreenData(hotTravels: hotTravels, recentNews: recentNews);

        hotTravelsTemp.clear();
        recentNewsTemp.clear();

        emit(GetHomeScreenDataSuccessState());
      } catch (e) {
        if (kDebugMode) {
          print(e.toString());
        }

        hotTravels.addAll(hotTravelsTemp);
        recentNews.addAll(recentNewsTemp);
        hotTravelsTemp.clear();
        recentNewsTemp.clear();

        emit(GetHomeScreenDataFailureState(e.toString()));
      }
    } else {
      showToast(
          msg: 'Please turn on wifi or mobile data',
          bgColor: Colors.red,
          txColor: Colors.white);
    }
  }

  void changeBottomNavigationBarIndex(int index) {
    currentIndex = index;
    emit(ChangeBottomNavigationBarIndex());
  }

  Future<void> getUserLocation() async {
    await userLocation.getUserLocation();
    emit(GetTheUserLocationName());
  }
}
