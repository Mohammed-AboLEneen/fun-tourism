import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fun_adventure/constants.dart';
import 'package:fun_adventure/cores/utils/images.dart';
import 'package:fun_adventure/cores/utils/sheard_preferance_helper.dart';
import 'package:fun_adventure/cores/utils/smooth_dots.dart';
import 'package:fun_adventure/features/authentication/presentation/view/authentcation.dart';
import 'package:fun_adventure/features/onboarding/presentation/view/widgets/custom_button.dart';
import 'package:fun_adventure/features/onboarding/presentation/view/widgets/pageview_item.dart';

import '../../../../cores/methods/navigate_pageview.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({super.key});

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage>
    with SingleTickerProviderStateMixin {
  late PageController _pageController;

  List<String> pageViewTitles = [
    'Enjoy with your friends',
    'Ability to book online',
    'Go on interesting trips',
  ];
  List<String> pageViewSubtitles = [
    'You Can Create Your Own Journey And Your Friends',
    'book after discussing the trip with others',
    'Experience various trips in new places',
  ];

  double progress = 0;
  late Color beginColor;
  late Color endColor;
  late String title;
  late String subtitle;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getPageViewTitleAndSubtitle();
    getPageViewBackgroundColor();
    initialPageViewController();
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      color: Color.lerp(beginColor, endColor, progress),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Positioned(
              top: h * .58,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: w * .15),
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 200),
                  opacity: getPageViewContainerOpacity(),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    constraints: BoxConstraints(maxWidth: w * .74),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Text(
                            title,
                            style: TextStyle(
                                fontSize: 25.sp,
                                fontWeight: FontWeight.w600,
                                color: Colors.black.withOpacity(.8)),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Text(
                            subtitle,
                            style: TextStyle(
                                fontSize: 25.sp,
                                color: Colors.black.withOpacity(.6)),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            PageView(
              controller: _pageController,
              children: [
                PageViewItem(
                  height: h,
                  width: w,
                  imagePath: ImagesClass.travelsSvgImage,
                ),
                PageViewItem(
                  height: h,
                  width: w,
                  imagePath: ImagesClass.travelBookingSvgImage,
                ),
                PageViewItem(
                  height: h,
                  width: w,
                  imagePath: ImagesClass.throughDesertSvgImage,
                ),
              ],
            ),
            Positioned(
                top: h * .85,
                left: w * .37,
                child: SmoothPageDots(
                  pageController: _pageController,
                )),
            Positioned(
                bottom: h * .03,
                right: w * .04,
                child: OnBoardingCustomIcon(
                  widget: const Icon(Icons.arrow_forward_ios_outlined),
                  height: h * .04,
                  width: w * .2,
                  tap: () {
                    if (progress < 2) {
                      navigatePageView(pageController: _pageController);
                    } else {
                      var sharedPreData = locator<SharedPreferenceHelper>();
                      sharedPreData.setBool(key: onBoardingKey, value: true);

                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (context, _, __) =>
                              const AuthenticationScreen(),
                          transitionsBuilder:
                              (context, animation, secondaryAnimation, child) {
                            const begin = Offset(0.0, 1.0);
                            const end = Offset.zero;
                            const curve = Curves.linear;

                            var tween = Tween(begin: begin, end: end)
                                .chain(CurveTween(curve: curve));

                            return SlideTransition(
                              position: animation.drive(tween),
                              child: child,
                            );
                          },
                        ),
                      );
                    }
                  },
                  color: Color.lerp(beginColor, endColor, progress),
                ))
          ],
        ),
      ),
    );
  }

  void getPageViewBackgroundColor() {
    if (progress > 1) {
      beginColor = const Color(0xffFFE5DE);
      endColor = const Color(0xffDBF6E5).withOpacity(.9);
    } else {
      beginColor = const Color(0xffDAD4C8);
      endColor = const Color(0xffFFE5DE);
    }
  }

  void getPageViewTitleAndSubtitle() {
    if (progress < .5) {
      title = pageViewTitles[0];
      subtitle = pageViewSubtitles[0];
    } else if (progress >= .5 && progress <= 1.5) {
      title = pageViewTitles[1];
      subtitle = pageViewSubtitles[1];
    } else {
      title = pageViewTitles[2];
      subtitle = pageViewSubtitles[2];
    }
  }

  void initialPageViewController() {
    _pageController = PageController()
      ..addListener(() {
        setState(() {
          progress = _pageController.page ?? 0;
          getPageViewBackgroundColor();
          getPageViewTitleAndSubtitle();
        });
      });
  }

  double getPageViewContainerOpacity() {
    if (progress == 0) {
      return 1;
    } else if (progress <= .5) {
      return 1 - ((progress + .5) * 1);
    } else if (progress > .5 && progress <= 1) {
      return progress;
    } else if (progress > 1 && progress <= 1.5) {
      return 1 - (((progress - 1) + .5) * 1);
    } else {
      return progress - 1;
    }
  }
}
