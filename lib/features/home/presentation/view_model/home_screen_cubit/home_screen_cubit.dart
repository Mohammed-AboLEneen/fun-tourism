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
import 'package:fun_adventure/features/home/presentation/view_model/main_screen_cubit/main_screen_cubit.dart';
import 'package:provider/provider.dart';

import '../../../../../cores/methods/download_image.dart';
import '../../../../../cores/utils/locator_manger.dart';
import '../../view/widgets/home_page.dart';
import '../../view/widgets/home_screen_widgets/profile_screen.dart';
import '../notifications_listener_provider/notification_listener_provider.dart';
import 'home_screen_states.dart';

class HomeScreenCubit extends Cubit<HomeScreenStates> {
  HomeScreenCubit() : super(HomeScreenInitState());

  static HomeScreenCubit get(context) => BlocProvider.of(context);

  late List<Widget> homeMenuPages = [const HomePage(), const ProfileScreen()];
  int currentPage = 0;

  Future<void> blocOperations(String uId, BuildContext context) async {
    getUserNotificationNumber(context);
    await getUserLocation();

    if (!context.mounted) return;
    getData(uId, context);
  }

  Future<void> getData(String uId, BuildContext context) async {
    // 1- first part of condition for internet connection state,
    // so when wifi is off or mobile data it will not request to get data from fireStore.
    // 2- second and third part of condition when open home screen more than once and creating its bloc
    // not request data again until user scroll up screen to refresh data

    if (LocatorManager.locator<AppMainScreenCubit>()
                .internetConnection
                .connectionStatus
                .name !=
            'none' &&
        (LocatorManager.locator<AppMainScreenCubit>().recentNews.isEmpty &&
            LocatorManager.locator<AppMainScreenCubit>().hotTravels.isEmpty)) {
      getUserNotificationNumber(context);
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

      print(LocatorManager.locator<AppMainScreenCubit>()
          .userData
          ?.userInfoData
          .photoURL);
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

  Future<void> getUserLocation() async {
    await LocatorManager.locator<AppMainScreenCubit>()
        .userLocation
        .getUserLocation();
    emit(GetTheUserLocationName());
  }

  void clearHomeScreenData() {
    LocatorManager.locator<AppMainScreenCubit>().hotTravels.clear();
    LocatorManager.locator<AppMainScreenCubit>().recentNews.clear();
  }

  Future<void> getUserNotificationNumber(BuildContext context) async {
    try {
      int number = await FireStoreServices.countUserNotifications();

      if (!context.mounted) return;
      Provider.of<NotificationListenerProvider>(context, listen: false)
          .setNotificationsNumber(number);
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  void changeTheCurrentHomeScreenPage(int index) {
    if (currentPage == index) return;

    currentPage = index;
    emit(ChangeTheCurrentHomeScreenPage());
  }
}
