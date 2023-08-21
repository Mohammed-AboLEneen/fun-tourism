import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
        colors: [Colors.white, Colors.teal.withOpacity(.9)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      )),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20),
          child: Column(
            children: [
              const Spacer(),
              Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                    ),
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * .4 +
                          progress * 140,
                      child: PageView(
                        controller: _pageController,
                        children: const [WelcomePage(), SignInPage()],
                      ),
                    ),
                  ),
                  Positioned(
                    right: MediaQuery.of(context).size.width * .02,
                    bottom: (MediaQuery.of(context).size.height * .02) +
                        progress * 150,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * .38 -
                          progress * 50,
                      height: 50,
                      child: CustomIcon(

                        tap: (){

                          _pageController.nextPage(duration: const Duration(milliseconds: 700), curve: Curves.easeInQuint);
                        },
                        widget: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 4),
                          child: Opacity(
                            opacity: progress < .6 ? 1 - progress : progress,
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
        ),
      ),
    );
  }
}
