import 'package:flutter/material.dart';
import 'package:fun_adventure/features/authentication/presentation/view/authentcation.dart';
import 'package:fun_adventure/features/authentication/presentation/view/widgets/verification_page.dart';
import 'package:fun_adventure/features/home/presentation/view/main_screen.dart';
import 'package:fun_adventure/features/home/presentation/view/widgets/home_screen_widgets/hot_travel/hot_travel_screen/hot_travel_screen.dart';
import 'package:fun_adventure/features/home/presentation/view/widgets/home_screen_widgets/pages/home_page/travels_screen/travels_screen.dart';
import 'package:fun_adventure/features/home/presentation/view/widgets/home_screen_widgets/pages/profile_screen/profile_screen.dart';
import 'package:fun_adventure/features/onboarding/presentation/view/onboarding.dart';
import 'package:fun_adventure/features/splash/presentation/view/splash.dart';

import '../../features/home/presentation/view/widgets/home_screen_widgets/pages/profile_screen/edit_screen.dart';

class RoutersClass {
  static String onBoardingScreen = '/onBoardingScreen';
  static String authenticationScreen = '/AuthenticationScreen';
  static String emailVerificationScreen = '/EmailVerificationScreen';
  static String appMainScreen = '/AppMainScreen';
  static String hotTravelScreen = '/HotTravelScreen';
  static String travelsScreen = '/TravelsScreen';
  static String profileScreen = '/ProfileScreen';
  static String editProfileScreen = '/EditProfileScreen';

  static Map<String, Widget Function(BuildContext)> routers = {
    '/': (context) => const SplashPage(),
    '/onBoardingScreen': (context) => const OnBoardingPage(),
    '/AuthenticationScreen': (context) => const AuthenticationScreen(),
    '/EmailVerificationScreen': (context) => const EmailVerificationPage(),
    '/AppMainScreen': (context) => const AppMainScreen(),
    '/HotTravelScreen': (context) => const HotTravelScreen(),
    '/TravelsScreen': (context) => const TravelsScreen(),
    '/ProfileScreen': (context) => const ProfileScreen(
          showLoadingIndicator: true,
        ),
    '/EditProfileScreen': (context) => const EditProfileScreen(),
  };
}
