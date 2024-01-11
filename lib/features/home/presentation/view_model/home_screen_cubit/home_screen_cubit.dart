import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fun_adventure/cores/methods/download_image.dart';
import 'package:fun_adventure/cores/methods/toast.dart';

import 'package:fun_adventure/cores/models/user_app_data/user_app_data.dart';
import 'package:fun_adventure/features/home/presentation/view_model/main_screen_cubit/main_screen_cubit.dart';
import 'package:provider/provider.dart';

import '../../../../../constants.dart';
import '../../../../../cores/utils/internet_connection.dart';
import '../../../../../cores/utils/locator_manger.dart';
import '../../../data/models/hot_travels_model/hot_travels_model.dart';
import '../../../data/models/recent_news_model/recent_news_model.dart';
import '../../view/widgets/home_screen_widgets/pages/home_page/home_page.dart';
import '../../view/widgets/home_screen_widgets/pages/profile_screen/profile_screen.dart';
import '../notifications_listener_provider/notification_listener_provider.dart';
import 'home_screen_states.dart';

class HomeScreenCubit extends Cubit<HomeScreenStates> {
  HomeScreenCubit() : super(HomeScreenInitState());

  static HomeScreenCubit get(context) => BlocProvider.of(context);

  late List<Widget> homeMenuPages = [
    const HomePage(),
    const ProfileScreen(
      heroTag: 'edit screen',
      showLoadingIndicator: true,
    )
  ];

  List<String> categoriesTitles = [
    'North Egypt',
    'South Egypt',
    'East Egypt',
    'West Egypt',
  ];

  int sliderBannerCurrentIndex = 0;
  double notification = 0;

  List<String> categoriesImagesUrl = [
    'https://th.bing.com/th/id/R.fce7404b15d00c3020f7eecdc5313836?rik=V8qh4TWh8NXp9w&pid=ImgRaw&r=0',
    'https://th.bing.com/th/id/R.0d23e67eabbb6c0f6a9e5fa7ad950a31?rik=gqXlAoKzqQl78w&pid=ImgRaw&r=0',
    'https://th.bing.com/th/id/OIP.RBRql-XKiGpHsGAMoCQ7-AHaCe?pid=ImgDet&rs=1',
    'https://www.tripsavvy.com/thmb/Ue5Tz-4fTb9OTBbEzBxlqa8UT_s=/2143x1399/filters:no_upscale():max_bytes(150000):strip_icc()/GettyImages-154260931-584169ec3df78c0230514c82.jpg',
  ];

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

    getUserNotificationNumber(context);

    BlocProvider.of<AppMainScreenCubit>(context)
        .requestUserNotifications(context);

    if ((LocatorManager.locator<AppMainScreenCubit>().recentNews.isEmpty &&
        LocatorManager.locator<AppMainScreenCubit>().hotTravels.isEmpty)) {
      getUserData(uId);
      getHomeScreen();
    }
  }

  Future<void> getUserData(String uId) async {
    emit(GetUserDataLoadingState());

    try {
      DocumentSnapshot<Map<String, dynamic>> data =
          await FirebaseFirestore.instance.collection('users').doc(uId).get();

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

  Future<void> getHomeScreen() async {
    try {
      List<RecentNewsModel> recentNews = [];
      List<HotTravelModel> hotTravels = [];

      emit(GetHomeScreenDataLoadingState());

      DocumentSnapshot<Map<String, dynamic>> data1 = await FirebaseFirestore
          .instance
          .collection('appData')
          .doc('last travels')
          .get();
      DocumentSnapshot<Map<String, dynamic>> data2 = await FirebaseFirestore
          .instance
          .collection('appData')
          .doc('recent news')
          .get();

      Map<String, dynamic> dataList1 = data1.data() as Map<String, dynamic>;
      Map<String, dynamic> dataList2 = data2.data() as Map<String, dynamic>;

      for (Map<String, dynamic> element in dataList1.values.toList()) {
        element['brief']['image'] =
            await downloadAndStoreImage(element['brief']['image']);

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
      showToast(
          msg: 'There Is An Network Error, Try Again',
          toastMessageType: ToastMessageType.failureMessage);
      LocatorManager.locator<InternetConnectionState>().connectionStatus;
      emit(GetHomeScreenDataFailureState('Failed To Connect To The Network'));
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      emit(GetHomeScreenDataFailureState(
          'Something Is Wrong. Please Try Again'));
    }
  }

  Future<void> getUserLocation() async {
    if (LocatorManager.locator<AppMainScreenCubit>()
        .userLocation
        .locationName
        .isEmpty) {
      await LocatorManager.locator<AppMainScreenCubit>()
          .userLocation
          .getUserLocation();
      emit(GetTheUserLocationName());
    }
  }

  void clearHomeScreenData() {
    LocatorManager.locator<AppMainScreenCubit>().hotTravels.clear();
    LocatorManager.locator<AppMainScreenCubit>().recentNews.clear();
  }

  Future<void> getUserNotificationNumber(BuildContext context) async {
    try {
      AggregateQuerySnapshot query = await FirebaseFirestore.instance
          .collection('users')
          .doc(uId)
          .collection('notifications')
          .count()
          .get();

      int notificationsNumber = query.count;
      if (!context.mounted) return;
      Provider.of<NotificationListenerProvider>(context, listen: false)
          .setNotificationsNumber(notificationsNumber);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  int currentPage = 0;

  // home screen has multi pages like profile and other pages we can change it using home menu.
  void changeTheCurrentHomeScreenPage(int index) {
    if (currentPage == index) return;

    currentPage = index;
    emit(ChangeTheCurrentHomeScreenPage());
  }
}
