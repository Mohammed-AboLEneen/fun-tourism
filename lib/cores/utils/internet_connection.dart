import 'dart:developer' as developer;

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/services.dart';
import 'package:fun_adventure/cores/methods/toast.dart';
import 'package:fun_adventure/cores/utils/locator_manger.dart';

class InternetConnectionState {
  ConnectivityResult connectionStatus = ConnectivityResult.none;
  final Connectivity connectivity = Connectivity();

  bool finishedInit = false;

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initConnectivity() async {
    connectivity.onConnectivityChanged.listen(_updateConnectionStatus);

    late List<ConnectivityResult> result;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      developer.log('Couldn\'t check connectivity status', error: e);
      return;
    }

    LocatorManager.locator<InternetConnectionState>().finishedInit = true;

    _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(List<ConnectivityResult> result) async {
    String temp = connectionStatus.name;
    LocatorManager.locator<InternetConnectionState>().connectionStatus =
        result.first;

    if (temp == 'none' &&
        (result.first.name == 'wifi' || result.first.name == 'mobile')) {
      showToast(
        msg: 'Refresh ...',
        toastMessageType: ToastMessageType.successMessage,
      );
    }
  }
}
