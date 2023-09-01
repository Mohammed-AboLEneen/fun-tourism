import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fun_adventure/cores/utils/images.dart';
import 'package:fun_adventure/features/authentication/presentation/view/widgets/sign_in.dart';
import 'package:fun_adventure/features/authentication/presentation/view/widgets/welcome.dart';

import 'custom_button.dart';

class LoginBody extends StatefulWidget {
  const LoginBody({super.key});

  @override
  State<LoginBody> createState() => _LoginBodyState();
}

class _LoginBodyState extends State<LoginBody> {
  late PageController _pageController;
  double progress = 0;

  @override
  void initState() {
    super.initState();

    _pageController = PageController()
      ..addListener(() {
        setState(() {
          progress = _pageController.page ?? 0;
        });
      });
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    return CustomScrollView(
      slivers: [
        SliverFillRemaining(
          hasScrollBody: false,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Image.asset(
                ImagesClass.welcomeImage,
                fit: BoxFit.fill,
                height: h,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20),
                child: Column(
                  children: [
                    const Spacer(),
                    Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.blue.withOpacity(.3),
                          ),
                          child: SizedBox(
                            height: h < 550.0
                                ? (h * .46) + (progress * (h * .3))
                                : (h * .4) + (progress * (h * .24)),
                            child: PageView(
                              controller: _pageController,
                              children: [
                                const WelcomePage(),
                                SignInPage(h: h * .4 + progress * 140)
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          right: w * .02,
                          bottom: h < 600
                              ? ((h * .03) + (progress * (h * .3)))
                              : (h * .03) + progress * h * .27,
                          child: SizedBox(
                            width: w * .35 - progress * 50,
                            height: h * .065,
                            child: CustomIcon(
                              tap: () {
                                _pageController.nextPage(
                                    duration: const Duration(milliseconds: 700),
                                    curve: Curves.easeInQuint);
                              },
                              widget: Center(
                                child: Opacity(
                                  opacity:
                                      progress < .6 ? 1 - progress : progress,
                                  child: Text(
                                    progress < .6 ? 'Get Started >' : 'Sign in',
                                    style: TextStyle(
                                        fontSize: 20.sp, color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
