import 'package:flutter/foundation.dart';
import 'package:fun_adventure/cores/methods/toast.dart';
import 'package:fun_adventure/cores/models/hot_travels_model/hot_travels_model.dart';
import 'package:hive/hive.dart';

import '../../constants.dart';
import '../models/recent_news_model/recent_news_model.dart';

Future<void> saveHomeScreenData(
    {required List<HotTravelModel> hotTravels,
    required List<RecentNewsModel> recentNews}) async {
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
    showToast(
        msg: 'Something wrong while saving data',
        toastMessageType: ToastMessageType.failureMessage);
    if (kDebugMode) {
      print(e.toString());
    }
    if (kDebugMode) {
      print(s);
    }
  }
}
