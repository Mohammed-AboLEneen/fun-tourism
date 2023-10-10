import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fun_adventure/features/home/presentation/view/main_screen.dart';
import 'package:fun_adventure/features/onboarding/presentation/view/onboarding.dart';

import '../../../../../constants.dart';
import '../../../../../cores/utils/images.dart';
import '../../../../../cores/utils/sheard_preferance_helper.dart';
import '../../../../authentication/presentation/view/authentcation.dart';

class SplashViewBody extends StatefulWidget {
  const SplashViewBody({super.key});

  @override
  State<SplashViewBody> createState() => _SplashViewBodyState();
}

class _SplashViewBodyState extends State<SplashViewBody>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();

    animation();
    futureNavigate();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AnimatedBuilder(
                animation: _animationController,
                builder: (_, __) {
                  return SizedBox(
                    height: (h * .1 * _animationController.value) + h * .3,
                    child: SvgPicture.asset(
                      ImagesClass.logoSvgImage,
                    ),
                  );
                })
          ],
        ),
      ),
    );
  }

  void animation() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _animationController.forward();
  }

  void futureNavigate() {
    Future.delayed(const Duration(seconds: 5), () {
      Widget beginWidget = beginWidgetApp();

      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => beginWidget),
          (route) => false);
    });
  }
}

Widget beginWidgetApp() {
  bool? onBoarding = SharedPreferenceHelper.getBool(key: onBoardingKey);

  if (onBoarding == null) {
    return const OnBoardingPage();
  } else {
    bool? login = SharedPreferenceHelper.getBool(key: loginKey);
    if (login == null) {
      return const AuthenticationScreen();
    } else {
      return const AppMainScreen();
    }
  }
}
