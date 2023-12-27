import 'package:fun_adventure/cores/utils/firebase_api.dart';
import 'package:fun_adventure/cores/utils/internet_connection.dart';
import 'package:get_it/get_it.dart';

import '../../features/home/presentation/view_model/main_screen_cubit/main_screen_cubit.dart';

class LocatorManager {
  static final GetIt locator = GetIt.instance;

  static void locateInternetConnectionStatus() {
    if (locator.isRegistered<InternetConnectionState>() == false) {
      locator.registerLazySingleton<InternetConnectionState>(
          () => InternetConnectionState());
    }
  }

  static void locateAppMainScreenCubit() {
    if (locator.isRegistered<AppMainScreenCubit>() == false) {
      locator.registerLazySingleton<AppMainScreenCubit>(
          () => AppMainScreenCubit());
    }
  }

  static void locateFirebaseMessagingObject() {
    if (locator.isRegistered<FirebaseApi>() == false) {
      locator.registerLazySingleton<FirebaseApi>(() => FirebaseApi());
    }
  }
}
