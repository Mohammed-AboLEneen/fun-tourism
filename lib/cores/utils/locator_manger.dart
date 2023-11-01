import 'package:get_it/get_it.dart';

import '../../features/home/presentation/view_model/main_screen_cubit/main_screen_cubit.dart';

class LocatorManager {
  static final GetIt locator = GetIt.instance;

  static void locateAppMainScreenCubit() {
    locator
        .registerLazySingleton<AppMainScreenCubit>(() => AppMainScreenCubit());
  }
}
