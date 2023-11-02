import 'package:flutter/material.dart';
import 'package:fun_adventure/features/authentication/presentation/view/authentcation.dart';
import 'package:fun_adventure/features/authentication/presentation/view/widgets/verification_page.dart';
import 'package:fun_adventure/features/home/presentation/view/home_screen.dart';
import 'package:fun_adventure/features/home/presentation/view/main_screen.dart';
import 'package:fun_adventure/features/onboarding/presentation/view/onboarding.dart';
import 'package:fun_adventure/features/splash/presentation/view/splash.dart';
import 'package:go_router/go_router.dart';

class RoutersClass {
  static const String splashScreenPath = "/splashScreen";
  static const String onBoardingPagePath = "/onBoarding";
  static const String authenticationScreenPath = "/authenticationScreen";
  static const String emailVerificationScreenPath = "emailVerificationScreen";
  static const String mainAppScreenPath = "/mainAppScreen";
  static const String homeScreenPath = "homeScreen";

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
              print('return this page');
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
        routes: <RouteBase>[
          GoRoute(
            path: 'homeScreen',
            builder: (BuildContext context, GoRouterState state) {
              return const HomeScreen();
            },
          ),
        ],
      ),
    ],
  );
}
