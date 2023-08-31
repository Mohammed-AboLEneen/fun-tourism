import 'package:flutter/cupertino.dart';
import 'package:fun_adventure/features/splash/presentation/view/splash.dart';
import 'package:go_router/go_router.dart';

import '../../features/authentication/presentation/view/login.dart';
import '../../features/authentication/presentation/view/register.dart';
import '../../features/home/presentation/view/home_page.dart';

class RoutersCLass {
  static String splashPage = '/';
  static String homePage = '/homePage';
  static String loginPage = '/loginPage';
  static String registerPage = '/registerPage';

  static final GoRouter router = GoRouter(
    routes: <RouteBase>[
      GoRoute(
        path: splashPage,
        builder: (BuildContext context, GoRouterState state) {
          return const SplashPage();
        },
      ),
      GoRoute(
        path: homePage,
        builder: (BuildContext context, GoRouterState state) {
          return const HomePage();
        },
      ),
      GoRoute(
        path: loginPage,
        builder: (BuildContext context, GoRouterState state) {
          return const LoginPage();
        },
      ),
      GoRoute(
        path: registerPage,
        builder: (BuildContext context, GoRouterState state) {
          return const RegisterPage();
        },
      )
    ],
  );
}
