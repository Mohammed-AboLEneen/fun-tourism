import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fun_adventure/cores/utils/images.dart';
import 'package:fun_adventure/features/authentication/presentation/view/methods/auth_container_size.dart';
import 'package:fun_adventure/features/authentication/presentation/view/widgets/icon_position.dart';
import 'package:fun_adventure/features/authentication/presentation/view/widgets/register_body.dart';
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
                width: w,
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
                            height: getPageViewContainerSize(
                                h: h, pageView: progress),
                            child: PageView(
                              controller: _pageController,
                              children: [
                                const WelcomePage(),
                                SignInPage(),
                                RegisterBody(),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          right: AuthIconInfo.getIconLeftWidth(
                              w: w, pageValue: progress),
                          bottom: AuthIconInfo.getIconBottomHeight(
                              h: h, pageValue: progress),
                          child: SizedBox(
                            width: AuthIconInfo.getIconWidth(
                                w: w, pageView: progress),
                            height: h * .065,
                            child: CustomIcon(
                              tap: () {
                                _pageController.nextPage(
                                    duration: const Duration(milliseconds: 700),
                                    curve: Curves.easeInQuint);
                              },
                              widget: Center(
                                child: Text(
                                  AuthIconInfo.getIconTitle(pageView: progress),
                                  style: TextStyle(
                                      fontSize: 20.sp, color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        )
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
