import 'dart:developer' as developer;

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/services.dart';
import 'package:fun_adventure/cores/methods/toast.dart';
import 'package:fun_adventure/cores/utils/locator_manger.dart';
import 'package:fun_adventure/features/home/presentation/view_model/main_screen_cubit/main_screen_cubit.dart';

class InternetConnectionState {
  ConnectivityResult connectionStatus = ConnectivityResult.none;
  final Connectivity connectivity = Connectivity();

  bool finishedInit = false;

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

    LocatorManager.locator<AppMainScreenCubit>()
        .internetConnection
        .finishedInit = true;

    _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    String temp = connectionStatus.name;
    LocatorManager.locator<AppMainScreenCubit>()
        .internetConnection
        .connectionStatus = result;

    if (temp == 'none' && (result.name == 'wifi' || result.name == 'mobile')) {
      showToast(
        msg: 'Refresh ...',
        toastMessageType: ToastMessageType.successMessage,
      );
    }

    LocatorManager.locator<AppMainScreenCubit>()
        .listenInternetConnectionState();
  }
}
