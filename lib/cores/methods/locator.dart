import 'package:fun_adventure/cores/models/hot_travels_model/hot_travels_model.dart';
import 'package:fun_adventure/cores/models/recent_news_model/recent_news_model.dart';
import 'package:fun_adventure/cores/models/user_app_data/user_app_data.dart';

import '../../constants.dart';

void setupUserDataLocator(UserAppData? user) {
  locator.registerSingleton<UserAppData>(user!);
}

void setupHotTravelsLocator(List<HotTravelModel>? user) {
  locator.registerSingleton<List<HotTravelModel>>(user!);
}

void setupRecentNewsLocator(List<RecentNewsModel>? user) {
  print('lolololololololol');
  locator.registerSingleton<List<RecentNewsModel>>(user!);
}
