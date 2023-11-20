import 'package:flutter/material.dart';
import 'package:fun_adventure/cores/models/hot_travels_model/hot_travels_model.dart';
import 'package:fun_adventure/features/authentication/presentation/view/authentcation.dart';
import 'package:fun_adventure/features/authentication/presentation/view/widgets/verification_page.dart';
import 'package:fun_adventure/features/home/presentation/view/main_screen.dart';
import 'package:fun_adventure/features/home/presentation/view/widgets/home_screen_widgets/pages/home_page/travels_screen/travels_screen.dart';
import 'package:fun_adventure/features/home/presentation/view/widgets/home_screen_widgets/pages/profile_screen/profile_screen.dart';
import 'package:fun_adventure/features/onboarding/presentation/view/onboarding.dart';
import 'package:fun_adventure/features/splash/presentation/view/splash.dart';
import 'package:go_router/go_router.dart';

import '../../features/home/presentation/view/widgets/home_screen_widgets/hot_travel/hot_travel_screen/hot_travel_screen.dart';

class RoutersClass {
  static const String splashScreenPath = "/splashScreen";
  static const String onBoardingPagePath = "/onBoarding";
  static const String authenticationScreenPath = "/authenticationScreen";
  static const String emailVerificationScreenPath = "emailVerificationScreen";
  static const String fromAuthScreenToEmailVerificationScreen =
      "$authenticationScreenPath/$emailVerificationScreenPath";
  static const String mainAppScreenPath = "/mainAppScreen";
  static const String profileScreenPath = "profileScreenPath";
  static const String fromMainAppScreenToProfileScreen =
      "$mainAppScreenPath/$profileScreenPath";
  static const String hotTravelScreenPath = "hotTravelScreen";
  static const String fromMainScreenToHotTravelScreen =
      "$mainAppScreenPath/$hotTravelScreenPath";
  static const String travelsScreen = 'travelsScreen';
  static const String fromMainScreenToTravelsScreen =
      '$mainAppScreenPath/$travelsScreen';

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
                pageBuilder: (context, state) => CustomTransitionPage(
                    child: HotTravelScreen(
                      hotTravelModel: state.extra as HotTravelModel,
                    ),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                      final tween = Tween<Offset>(
                        begin: const Offset(1.0, 0.0),
                        end: Offset.zero,
                      );
                      final curvedAnimation = CurvedAnimation(
                        parent: animation,
                        curve: Curves.ease,
                      );

                      return SlideTransition(
                        position: tween.animate(curvedAnimation),
                        child: child,
                      );
                    })),
            GoRoute(
              path: 'profileScreenPath',
              pageBuilder: (BuildContext context, GoRouterState state) =>
                  CustomTransitionPage(
                      child: ProfileScreen(
                        id: state.extra as String,
                      ),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                        final tween = Tween<Offset>(
                          begin: const Offset(0.0, 1),
                          end: Offset.zero,
                        );
                        final curvedAnimation = CurvedAnimation(
                          parent: animation,
                          curve: Curves.ease,
                        );

                        return SlideTransition(
                          position: tween.animate(curvedAnimation),
                          child: child,
                        );
                      }),
            ),
            GoRoute(
              path: 'travelsScreen',
              pageBuilder: (BuildContext context, GoRouterState state) =>
                  CustomTransitionPage(
                      child: const TravelsScreen(),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                        final tween = Tween<Offset>(
                          begin: const Offset(-1, 0),
                          end: Offset.zero,
                        );
                        final curvedAnimation = CurvedAnimation(
                          parent: animation,
                          curve: Curves.ease,
                        );

                        return SlideTransition(
                          position: tween.animate(curvedAnimation),
                          child: child,
                        );
                      }),
            ),
          ]),
    ],
  );
}
