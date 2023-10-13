import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
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
    const LolScreen(
      title: 'Welcome man',
    ),
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
      final box1 = await Hive.openBox(hotTravelsBox);
      final box2 = await Hive.openBox(recentNewsBox);


      hotTravels = box1.get(hotTravelsKey).cast<HotTravelModel>();
      recentNews = box2.get(recentNewsKey).cast<RecentNewsModel>();

      // // close all boxes when firebase data coming and update hive boxes values.

      await box1.close();
      await box2.close();
      emit(GetLocalAppDataSuccessState());
    } catch (e, x) {
      print(e.toString());
      print(x);
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

  Future<Uint8List> downloadAndStoreImage(String imageUrl) async {
    final cacheManager = DefaultCacheManager();
    await cacheManager.downloadFile(imageUrl);
    return await retrieveImageFromCache(imageUrl);
  }

  Future<Uint8List> retrieveImageFromCache(String imageUrl) async {
    final cacheManager = DefaultCacheManager();
    final File file = await cacheManager.getSingleFile(imageUrl);
    return file.readAsBytesSync();
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
        element['image'] = await downloadAndStoreImage(element['image']);

        hotTravels.add(HotTravelModel.fromJson(element));
      }

      for (Map<String, dynamic> element in dataList2.values.toList()) {
        element['image'] = await downloadAndStoreImage(element['image']);
        recentNews.add(RecentNewsModel.fromJson(element));
      }

      _saveHomeScreenData();

      emit(GetHomeScreenDataSuccessState());
    } catch (e) {
      print(e.toString());
      emit(GetHomeScreenDataFailureState(e.toString()));
    }
  }

  Future<void> _saveUserAppData() async {
    try {
      final box = await Hive.openBox<UserAppData>(userBox);
      await box.put(userDataKey, userData); // save it in hive
      box.close();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> _saveHomeScreenData() async {
    try {
      print(Hive.isBoxOpen(hotTravelsBox));

      late final box1;

      if (Hive.isBoxOpen(hotTravelsBox)) {
        box1 = Hive.box(hotTravelsBox);
      } else {
        box1 = await Hive.openBox(hotTravelsBox);
      }

      late final box2;
      if (Hive.isBoxOpen(recentNewsBox)) {
        box2 = Hive.box(recentNewsBox);
      } else {
        box2 = await Hive.openBox(recentNewsBox);
      }

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
