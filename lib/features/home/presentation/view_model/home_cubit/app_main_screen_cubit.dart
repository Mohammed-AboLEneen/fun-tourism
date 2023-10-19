import 'dart:async';
import 'dart:developer' as developer;
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fun_adventure/cores/methods/toast.dart';
import 'package:fun_adventure/cores/models/hot_travels_model/hot_travels_model.dart';
import 'package:fun_adventure/cores/models/recent_news_model/recent_news_model.dart';
import 'package:fun_adventure/cores/models/user_app_data/user_app_data.dart';
import 'package:fun_adventure/cores/utils/firestore_service.dart';
import 'package:fun_adventure/features/home/presentation/view/widgets/home_screen_widgets/t.dart';
import 'package:fun_adventure/features/home/presentation/view_model/home_cubit/app_main_screen_states.dart';
import 'package:hive/hive.dart';

import '../../../../../constants.dart';
import '../../view/widgets/home_screen_widgets/home_screen.dart';
import '../../view/widgets/home_screen_widgets/l.dart';

class AppMainScreenCubit extends Cubit<AppMainScreenStates> {
  AppMainScreenCubit() : super(AppMainScreenInitState());

  UserAppData? userData;
  int currentIndex = 0;
  ConnectivityResult _connectionStatus = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();
  bool isGetHomeScreenData = false;
  bool isGetUserAppData = false;

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
    const DragContainer(),
    const HomeScreen(),
  ];

  static AppMainScreenCubit get(context) => BlocProvider.of(context);

  Future<void> blocOperations(String userEmail) async {
    await initConnectivity();
    initLocalAppData();
    getUserData(userEmail ?? '');

    // this function is called when get the state of the internet,
    // so when open wifi or mobile after close it,
    // this function will be called again to get the new data.
    // getHomeScreen();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initConnectivity() async {
    _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);

    late ConnectivityResult result;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      developer.log('Couldn\'t check connectivity status', error: e);
      return;
    }

    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    String temp = _connectionStatus.name;
    _connectionStatus = result;

    if ((temp == 'none' &&
        (result.name == 'wifi' || result.name == 'mobile')) &&
        isGetHomeScreenData == false) {
      getHomeScreen();
    }

    print(result.name);
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
      showToast(
          msg: 'There is no saved data, connect to the internet',
          bgColor: Colors.red,
          txColor: Colors.white);
      if (kDebugMode) {
        print(e.toString());
      }
      if (kDebugMode) {
        print(x);
      }
      emit(GetLocalAppDataFailureState());
    }
  }

  Future<void> getUserData(String email,) async {
    print(_connectionStatus.name);
    if (_connectionStatus.name != 'none') {
      isGetUserAppData = true;
      emit(GetUserDataLoadingState());

      try {
        DocumentSnapshot<Object?> data =
        await FireStoreServices.getUserData(email: email);
        userData = UserAppData.fromJson(data.data() as Map<String, dynamic>);
        await _saveUserAppData();
        print('get user data');
        emit(GetUserDataSuccessState());
      } catch (e) {
        if (kDebugMode) {
          print(e.toString());
        }

        isGetUserAppData = false;

        emit(GetUserDataFailureState(e.toString()));
      }
    } else {
      showToast(
          msg: 'There is no internet',
          bgColor: Colors.red,
          txColor: Colors.white);
    }
  }

  // this function is called when get the state of the internet,
  // so when open wifi or mobile after close it,
  // this function will be called again to get the new data.
  Future<void> getHomeScreen() async {
    if (_connectionStatus.name != 'none') {
      isGetHomeScreenData = true;
      emit(GetHomeScreenDataLoadingState());
      try {
        DocumentSnapshot<Object?> data1 =
        await FireStoreServices.getHomeScreenData('last travels');
        DocumentSnapshot<Object?> data2 =
        await FireStoreServices.getHomeScreenData('recent news');

        Map<String, dynamic> dataList1 = data1.data() as Map<String, dynamic>;
        Map<String, dynamic> dataList2 = data2.data() as Map<String, dynamic>;

        hotTravels.clear();
        recentNews.clear();
        for (Map<String, dynamic> element in dataList1.values.toList()) {
          element['image'] = await downloadAndStoreImage(element['image']);
          print(element['title']);
          hotTravels.add(HotTravelModel.fromJson(element));
        }

        for (Map<String, dynamic> element in dataList2.values.toList()) {
          element['image'] = await downloadAndStoreImage(element['image']);
          recentNews.add(RecentNewsModel.fromJson(element));
        }

        _saveHomeScreenData();

        isGetHomeScreenData = false;
        emit(GetHomeScreenDataSuccessState());
      } catch (e) {
        if (kDebugMode) {
          print(e.toString());
        }

        isGetHomeScreenData = false;
        emit(GetHomeScreenDataFailureState(e.toString()));
      }
    } else {
      showToast(
          msg: 'There is no internet',
          bgColor: Colors.red,
          txColor: Colors.white);
    }
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

  Future<void> _saveUserAppData() async {
    try {
      final box = await Hive.openBox<UserAppData>(userBox);
      await box.put(userDataKey, userData!); // save it in hive
      box.close();
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  Future<void> _saveHomeScreenData() async {
    try {
      if (kDebugMode) {
        print(Hive.isBoxOpen(hotTravelsBox));
      }

      final box1 = Hive.isBoxOpen(hotTravelsBox)
          ? Hive.box(hotTravelsBox)
          : await Hive.openBox(hotTravelsBox);
      final box2 = Hive.isBoxOpen(recentNewsBox)
          ? Hive.box(recentNewsBox)
          : await Hive.openBox(recentNewsBox);

      await box1.put(hotTravelsKey, hotTravels); // save it in hive
      await box2.put(recentNewsKey, recentNews); // save it in hive

      box1.close();
      box2.close();
    } catch (e, s) {
      if (kDebugMode) {
        print(e.toString());
      }
      if (kDebugMode) {
        print(s);
      }
    }
  }

  void changeBottomNavigationBarIndex(int index) {
    currentIndex = index;
    emit(ChangeBottomNavigationBarIndex());
  }
}
