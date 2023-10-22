import 'dart:developer' as developer;

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fun_adventure/cores/methods/toast.dart';
import 'package:fun_adventure/features/home/presentation/view_model/home_cubit/app_main_screen_cubit.dart';

class InternetConnectionState {
  late AppMainScreenCubit appMainScreenCubit;
  ConnectivityResult connectionStatus = ConnectivityResult.none;
  final Connectivity connectivity = Connectivity();

  void initCubitObject(AppMainScreenCubit cubit) {
    appMainScreenCubit = cubit;
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initConnectivity() async {
    connectivity.onConnectivityChanged.listen(_updateConnectionStatus);

    late ConnectivityResult result;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      developer.log('Couldn\'t check connectivity status', error: e);
      return;
    }

    _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    String temp = connectionStatus.name;
    connectionStatus = result;

    if ((temp == 'none' &&
        (result.name == 'wifi' || result.name == 'mobile')) &&
        appMainScreenCubit.isGetHomeScreenData == false) {
      print('lolo');
      showToast(
          msg: 'Internet is back, Refresh Now !',
          bgColor: Colors.green,
          txColor: Colors.white);
    }

    appMainScreenCubit.getHomeScreen();
  }
}
