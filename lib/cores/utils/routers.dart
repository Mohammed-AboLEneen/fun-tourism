import 'package:flutter/cupertino.dart';
import 'package:fun_adventure/features/splash/presentation/view/splash.dart';
import 'package:go_router/go_router.dart';

import '../../features/home/presentation/view/home_page.dart';

class RoutersCLass{

  static String splashPage = '/';
  static String homePage = '/homePage';

  static final GoRouter router = GoRouter(
    routes: <RouteBase>[
      GoRoute(
        path: splashPage,
        builder: (BuildContext context, GoRouterState state) {
          return const SplashViewWidget();
        },
      ),

      GoRoute(
        path: homePage,
        builder: (BuildContext context, GoRouterState state) {
          return const HomePage();
        },
      )
    ],
  );

}