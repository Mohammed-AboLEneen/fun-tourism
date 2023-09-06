import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fun_adventure/cores/methods/navigate_pageview.dart';
import 'package:fun_adventure/cores/utils/images.dart';
import 'package:fun_adventure/features/authentication/presentation/view/methods/auth_container_size.dart';
import 'package:fun_adventure/features/authentication/presentation/view/widgets/auth_icon_info.dart';
import 'package:fun_adventure/features/authentication/presentation/view/widgets/custom_button.dart';
import 'package:fun_adventure/features/authentication/presentation/view/widgets/login_page.dart';
import 'package:fun_adventure/features/authentication/presentation/view/widgets/register_page.dart';
import 'package:fun_adventure/features/authentication/presentation/view/widgets/welcome_page.dart';

class AuthenticationScreen extends StatefulWidget {
  const AuthenticationScreen({super.key});

  @override
  State<AuthenticationScreen> createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  late PageController _pageController;
  double progress = 0;

  @override
  void initState() {
    super.initState();

    _pageController = PageController()
      ..addListener(() {
        setState(() {
          print('rebuild');
          progress = _pageController.page ?? 0;
        });
      });
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.transparent,
      body: CustomScrollView(
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
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 20),
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
                                  LoginPage(
                                    pageController: _pageController,
                                  ),
                                  RegisterPage(),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            right: AuthIconInfo.getAuthIconLeftWidth(
                                w: w, pageValue: progress),
                            bottom: AuthIconInfo.getAuthIconBottomHeight(
                                h: h, pageValue: progress),
                            child: SizedBox(
                              width: AuthIconInfo.getAuthIconWidth(
                                  w: w, pageView: progress),
                              height: h * .065,
                              child: CustomIcon(
                                tap: () {
                                  if (progress == 0) {
                                    navigatePageView(
                                        pageController: _pageController);
                                  }

                                  if (progress == 1) {}
                                  if (progress == 2) {}
                                },
                                widget: Center(
                                  child: AnimatedOpacity(
                                    opacity:
                                        AuthIconInfo.getAuthIconTitleOpacity(
                                            pageView: progress),
                                    duration: const Duration(milliseconds: 500),
                                    child: Text(
                                      AuthIconInfo.getAuthIconTitle(
                                          pageView: progress),
                                      style: TextStyle(
                                          fontSize: 20.sp, color: Colors.white),
                                    ),
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
      ),
    );
  }
}
