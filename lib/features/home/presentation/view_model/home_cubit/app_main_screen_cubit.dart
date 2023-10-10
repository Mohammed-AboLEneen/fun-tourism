import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fun_adventure/cores/models/hot_travels_model/hot_travels_model.dart';
import 'package:fun_adventure/cores/models/recent_news_model/recent_news_model.dart';
import 'package:fun_adventure/cores/models/user_app_data/user_app_data.dart';
import 'package:fun_adventure/cores/utils/firestore_service.dart';
import 'package:fun_adventure/features/home/presentation/view/widgets/home_screen_widgets/t.dart';
import 'package:fun_adventure/features/home/presentation/view_model/home_cubit/app_main_screen_states.dart';
import 'package:hive/hive.dart';

import '../../../../../constants.dart';
import '../../view/widgets/home_screen_widgets/home_screen.dart';

class AppMainScreenCubit extends Cubit<AppMainScreenStates> {
  AppMainScreenCubit() : super(AppMainScreenInitState());

  late UserAppData userData;

  int currentIndex = 0;

  List<IconData> bottomNavigationBarIcons = [
    FontAwesomeIcons.house,
    FontAwesomeIcons.rocketchat,
    FontAwesomeIcons.magnifyingGlass,
    FontAwesomeIcons.plus,
  ];

  List<RecentNewsModel> recentNews = [];
  List<HotTravelModel> hotTravels = [];

  List<Widget> screens = [
    const HomeScreen(),
    const LolScreen(),
    const HomeScreen(),
    const HomeScreen(),
  ];

  static AppMainScreenCubit get(context) => BlocProvider.of(context);

  Future<bool> checkIfUserDataSavedLocal() async {
    final box = await Hive.openBox<UserAppData>(userBox);
    return box.isEmpty;
  }

  Future<void> initLocalAppData() async {
    try {
      final box1 = await Hive.openBox<List<dynamic>>(hotTravelsBox);
      final box2 = await Hive.openBox<List<dynamic>>(recentNewsBox);
      final box3 = await Hive.openBox<UserAppData>(userDataKey);

      print('getting local data');

      hotTravels = box1.values.first.cast<HotTravelModel>();
      recentNews = box2.values.first.cast<RecentNewsModel>();

      print(hotTravels[0].availablePlaces);
      print(recentNews[0].image);
      print(box1.get(hotTravelsBox)?[0].price);

      box1.close();
      box2.close();
      box3.close();
      emit(GetLocalAppDataSuccessState());
    } catch (e) {
      print(e.toString());
      emit(GetLocalAppDataFailureState());
    }
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

  Future<void> getHomeScreen() async {
    emit(GetHomeScreenDataLoadingState());

    try {
      DocumentSnapshot<Object?> data1 =
          await FireStoreServices.getHomeScreenData('last travels');
      DocumentSnapshot<Object?> data2 =
          await FireStoreServices.getHomeScreenData('recent news');

      Map<String, dynamic> dataList1 = data1.data() as Map<String, dynamic>;
      Map<String, dynamic> dataList2 = data2.data() as Map<String, dynamic>;

      for (Map<String, dynamic> element in dataList1.values.toList()) {
        hotTravels.add(HotTravelModel.fromJson(element));
      }

      for (Map<String, dynamic> element in dataList2.values.toList()) {
        recentNews.add(RecentNewsModel.fromJson(element));
      }

      _saveHomeScreenData();

      print('home screen data is Saaaaaaaaaaaaaaaved');
      emit(GetHomeScreenDataSuccessState());
    } catch (e) {
      print(e.toString());
      emit(GetHomeScreenDataFailureState(e.toString()));
    }
  }

  Future<void> _saveUserAppData() async {
    print('start to save user info');
    try {
      final box = await Hive.openBox<UserAppData>(userBox);
      await box.put(userDataKey, userData); // save it in hive
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> _saveHomeScreenData() async {
    try {
      print('start save home screen Data');
      final box1 = await Hive.openBox<List<HotTravelModel>>(hotTravelsBox);
      final box2 = await Hive.openBox<List<RecentNewsModel>>(recentNewsBox);
      await box1.put(hotTravelsKey, hotTravels); // save it in hive
      await box2.put(recentNewsKey, recentNews); // save it in hive

      box1.close();
      box2.close();
    } catch (e, s) {
      print(e.toString());
      print(s);
    }
  }
}
