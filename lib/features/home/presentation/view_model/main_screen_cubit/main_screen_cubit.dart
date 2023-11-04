import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fun_adventure/cores/models/notification_model.dart';

import '../../../../../cores/models/hot_travels_model/hot_travels_model.dart';
import '../../../../../cores/models/recent_news_model/recent_news_model.dart';
import '../../../../../cores/models/user_app_data/user_app_data.dart';
import '../../../../../cores/utils/get_location.dart';
import '../../../../../cores/utils/internet_connection.dart';
import '../../view/home_screen.dart';
import '../../view/widgets/chats_screen_widgets/chat_screen_widget.dart';
import 'main_screen_states.dart';

class AppMainScreenCubit extends Cubit<AppMainScreenStates> {
  AppMainScreenCubit() : super(AppMainScreenInitState());

  static AppMainScreenCubit get(context) => BlocProvider.of(context);

  InternetConnectionState internetConnection = InternetConnectionState();

  UserAppData? userData;

  int currentIndex = 0;

  List<Widget> screens = [
    const HomeScreen(),
    const ChatScreenWidget(),
    const HomeScreen(),
    const HomeScreen(),
  ];

  void listenInternetConnectionState() {
    emit(InternetConnectionStateChangedState());
  }

  List<IconData> bottomNavigationBarIcons = [
    FontAwesomeIcons.house,
    FontAwesomeIcons.rocketchat,
    FontAwesomeIcons.magnifyingGlass,
    FontAwesomeIcons.plus,
  ];

  List<RecentNewsModel> recentNews = [];
  List<HotTravelModel> hotTravels = [];
  List<NotificationModel> userNotifications = [];

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
}
