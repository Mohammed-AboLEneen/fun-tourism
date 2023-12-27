import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fun_adventure/cores/models/notification_model/notification_model.dart';
import 'package:fun_adventure/cores/utils/locator_manger.dart';
import 'package:fun_adventure/features/home/presentation/view/notifications_screen.dart';
import 'package:provider/provider.dart';

import '../../../../../constants.dart';
import '../../../../../cores/models/hot_travels_model/hot_travels_model.dart';
import '../../../../../cores/models/recent_news_model/recent_news_model.dart';
import '../../../../../cores/models/user_app_data/user_app_data.dart';
import '../../../../../cores/utils/get_location.dart';
import '../../view/add_travel_screen.dart';
import '../../view/home_screen.dart';
import '../notifications_listener_provider/notification_listener_provider.dart';
import 'main_screen_states.dart';

class AppMainScreenCubit extends Cubit<AppMainScreenStates> {
  AppMainScreenCubit() : super(AppMainScreenInitState());

  static AppMainScreenCubit get(context) => BlocProvider.of(context);

  UserAppData? userData;

  int currentIndex = 0;

  List<Widget> screens = [
    const HomeScreen(),
    const NotificationsScreen(),
    const AddTravelScreen()
  ];

  List<IconData> bottomNavigationBarIcons = [
    FontAwesomeIcons.house,
    FontAwesomeIcons.bell,
    FontAwesomeIcons.plus,
  ];

  List<RecentNewsModel> recentNews = [];
  List<HotTravelModel> hotTravels = [];
  List<NotificationModel>? userNotifications;

  UserLocation userLocation = UserLocation();

  void setUserData(UserAppData uAppData) {
    userData = uAppData;
  }

  void setRecentNewsList(List<RecentNewsModel> rNews) {
    recentNews.addAll(rNews);
  }

  void setHotTravelsList(List<HotTravelModel> hTravels) {
    hotTravels.addAll(hTravels);
  }

  void changeNavigationBar(index) {
    currentIndex = index;
    emit(ChangeNavigationBarState());
  }

  void changePhotoURLValue(String url) {
    LocatorManager.locator<AppMainScreenCubit>()
        .userData
        ?.userInfoData
        .photoURL = url;
    emit(ChangePhotoURLState());
  }

  void changeUserNameValue(String name) {
    LocatorManager.locator<AppMainScreenCubit>()
        .userData
        ?.userInfoData
        .displayName = name;
    emit(ChangeUserNameState());
  }

  Future<void> requestUserNotifications(BuildContext context) async {
    print('begin');
    emit(LoadingGetUserNotificationsState());

    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(uId)
          .collection('notifications')
          .get();
      List<NotificationModel> notifications = [];

      for (var element in querySnapshot.docs) {
        Map<String, dynamic> data = element.data() as Map<String, dynamic>;

        notifications.add(NotificationModel.fromNotification(
            notificationTitle: data['notification']['title'],
            notificationBody: data['notification']['body'],
            notData: data['data']));
      }

      LocatorManager.locator<AppMainScreenCubit>().userNotifications = [];
      LocatorManager.locator<AppMainScreenCubit>()
          .userNotifications!
          .addAll(notifications.reversed);
      if (!context.mounted) return;
      Provider.of<NotificationListenerProvider>(context, listen: false)
          .setNotificationsNumber(LocatorManager.locator<AppMainScreenCubit>()
                  .userNotifications
                  ?.length ??
              0);
      emit(SuccessGetUserNotificationsState());
    } catch (e) {
      print(e.toString());
      emit(FailureGetUserNotificationsState());
    }
  }

  Future<QuerySnapshot> getUserNotifications() async {
    return await FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .collection('notifications')
        .get();
  }
}
