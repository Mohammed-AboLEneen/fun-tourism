import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fun_adventure/cores/methods/toast.dart';
import 'package:fun_adventure/cores/models/hot_travels_model/hot_travels_model.dart';
import 'package:fun_adventure/cores/models/recent_news_model/recent_news_model.dart';
import 'package:fun_adventure/cores/models/user_app_data/user_app_data.dart';
import 'package:fun_adventure/cores/utils/firestore_service.dart';
import 'package:fun_adventure/cores/utils/screen_dimentions.dart';
import 'package:fun_adventure/features/home/presentation/view_model/main_screen_cubit/main_screen_cubit.dart';

import '../../../../../cores/methods/download_image.dart';
import '../../../../../cores/utils/locator_manger.dart';
import 'home_screen_states.dart';

class HomeScreenCubit extends Cubit<HomeScreenStates> {
  HomeScreenCubit() : super(HomeScreenInitState());

  static HomeScreenCubit get(context) => BlocProvider.of(context);

  double notificationScreenHeight = 0;
  bool notificationScreenIsOpened = false;
  bool notificationScreenBodyVisible = false;

  Future<void> blocOperations(String uId, BuildContext context) async {
    // init AppMainScreenCubit object to use it in this cubit

    await getUserLocation();
    getData(uId);
  }

  void clearHomeScreenData() {
    LocatorManager.locator<AppMainScreenCubit>().hotTravels.clear();
    LocatorManager.locator<AppMainScreenCubit>().recentNews.clear();
  }

  Future<void> getData(String uId) async {
    if (LocatorManager.locator<AppMainScreenCubit>()
            .internetConnection
            .connectionStatus
            .name !=
        'none') {
      clearHomeScreenData();
      getUserData(uId);
      getHomeScreen();
    } else {
      showToast(msg: 'Please turn on wifi or mobile data', isFailure: true);
    }
  }

  Future<void> getUserData(String uId) async {
    emit(GetUserDataLoadingState());

    try {
      DocumentSnapshot<Object?> data =
          await FireStoreServices.getUserData(uId: uId);

      LocatorManager.locator<AppMainScreenCubit>().setUserData(
          UserAppData.fromJson(data.data() as Map<String, dynamic>));

      emit(GetUserDataSuccessState());
    } on SocketException catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }

      emit(GetUserDataFailureState('Failed To Connect To The Network'));
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      emit(GetUserDataFailureState('Something Is Wrong. Please Try Again'));
    }
  }

  // this function is called when get the state of the internet,
  // so when open wifi or mobile after close it,
  // this function will be called again to get the new data.
  Future<void> getHomeScreen() async {
    try {
      List<RecentNewsModel> recentNews = [];
      List<HotTravelModel> hotTravels = [];

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

      LocatorManager.locator<AppMainScreenCubit>()
          .setHotTravelsList(hotTravels);
      LocatorManager.locator<AppMainScreenCubit>()
          .setRecentNewsList(recentNews);

      emit(GetHomeScreenDataSuccessState());
    } on SocketException {
      showToast(msg: 'There Is An Network Error, Try Again', isFailure: true);
      emit(GetUserDataFailureState('Failed To Connect To The Network'));
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      emit(GetUserDataFailureState('Something Is Wrong. Please Try Again'));
    }
  }

  void openNotificationScreen(BuildContext context) {
    notificationScreenIsOpened = true;
    changeNotificationsScreenHeight(context);
    emit(OpenNotificationsScreenState());
  }

  void closeNotificationScreen(BuildContext context) {
    setTheNotificationsScreenBodyVisibility(false);
    notificationScreenIsOpened = false;
    changeNotificationsScreenHeight(context);
    emit(CloseNotificationsScreenState());
  }

  void setTheNotificationsScreenBodyVisibility(bool state) {
    notificationScreenBodyVisible = state;
    emit(ChangeNotificationScreenBodyVisibilityState());
  }

  void changeNotificationsScreenHeight(BuildContext context) {
    notificationScreenHeight =
        notificationScreenIsOpened ? context.height * .75 : 0;
  }

  Future<void> getUserLocation() async {
    await LocatorManager.locator<AppMainScreenCubit>()
        .userLocation
        .getUserLocation();
    emit(GetTheUserLocationName());
  }
}
