import 'package:flutter/material.dart';
import 'package:fun_adventure/cores/models/hot_travels_model/hot_travels_model.dart';
import 'package:fun_adventure/features/authentication/presentation/view/authentcation.dart';
import 'package:fun_adventure/features/authentication/presentation/view/widgets/verification_page.dart';
import 'package:fun_adventure/features/home/presentation/view/main_screen.dart';
import 'package:fun_adventure/features/onboarding/presentation/view/onboarding.dart';
import 'package:fun_adventure/features/splash/presentation/view/splash.dart';
import 'package:go_router/go_router.dart';

import '../../features/home/presentation/view/widgets/home_screen_widgets/hot_travel_screen.dart';

class RoutersClass {
  static const String splashScreenPath = "/splashScreen";
  static const String onBoardingPagePath = "/onBoarding";
  static const String authenticationScreenPath = "/authenticationScreen";
  static const String emailVerificationScreenPath = "emailVerificationScreen";
  static const String fromAuthScreenToEmailVerificationScreen =
      "$authenticationScreenPath/$emailVerificationScreenPath";
  static const String mainAppScreenPath = "/mainAppScreen";
  static const String hotTravelScreenPath = "hotTravelScreen";
  static const String fromMainScreenToHotTravelScreen =
      "$mainAppScreenPath/$hotTravelScreenPath";

  static final GoRouter router = GoRouter(
    routes: <RouteBase>[
      GoRoute(
        path: '/',
        builder: (BuildContext context, GoRouterState state) {
          return const SplashPage();
        },
      ),
      GoRoute(
        path: '/onBoarding',
        builder: (BuildContext context, GoRouterState state) {
          return const OnBoardingPage();
        },
      ),
      GoRoute(
        path: '/authenticationScreen',
        builder: (BuildContext context, GoRouterState state) {
          return const AuthenticationScreen();
        },
        routes: <RouteBase>[
          GoRoute(
            path: 'emailVerificationScreen',
            builder: (BuildContext context, GoRouterState state) {
              return const EmailVerificationPage();
            },
          ),
        ],
      ),
      GoRoute(
          path: '/mainAppScreen',
          builder: (BuildContext context, GoRouterState state) {
            return const AppMainScreen();
          },
          routes: [
            GoRoute(
              path: 'hotTravelScreen',
              builder: (BuildContext context, GoRouterState state) {
                return HotTravelScreen(
                  hotTravelModel: state.extra as HotTravelModel,);
              },
            ),
          ]),
    ],
  );
}
