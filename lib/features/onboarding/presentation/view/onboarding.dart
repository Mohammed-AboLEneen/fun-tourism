import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fun_adventure/cores/utils/images.dart';
import 'package:fun_adventure/features/onboarding/presentation/view/widgets/custom_button.dart';
import 'package:fun_adventure/features/onboarding/presentation/view/widgets/smooth_dots.dart';

import '../../../../cores/methods/navigate_pageview.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({super.key});

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage>
    with SingleTickerProviderStateMixin {
  late PageController _pageController;
  double progress = 0;

  Color? beginColor = const Color(0xffDAD4C8);
  Color? endColor = const Color(0xffFFE5DE);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _pageController = PageController()
      ..addListener(() {
        setState(() {
          progress = _pageController.page ?? 0;

          if (progress > 1) {
            beginColor = const Color(0xffFFE5DE);
            endColor = const Color(0xffDBF6E5).withOpacity(.9);
          }
        });
      });
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
                          'Travel With Your Friends',
                          style: TextStyle(
                              fontSize: 25.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.black.withOpacity(.8)),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Text(
                          'You Can Create Your Own Journey And Your Friends',
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
            PageView(
              controller: _pageController,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: h * .15),
                  child: Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      CircleAvatar(
                          radius: h * .17,
                          backgroundColor: Colors.white.withOpacity(.5)),
                      SvgPicture.asset(
                        ImagesClass.travelsImage,
                        width: w * .9,
                        fit: BoxFit.cover,
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: h * .3),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      CircleAvatar(
                        radius: h * .17,
                        backgroundColor: Colors.white.withOpacity(.4),
                      ),
                      SvgPicture.asset(
                        ImagesClass.travelsImage,
                        width: w * .9,
                        fit: BoxFit.cover,
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: h * .3),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      CircleAvatar(
                        radius: h * .17,
                        backgroundColor: Colors.white.withOpacity(.5),
                      ),
                      SvgPicture.asset(
                        ImagesClass.travelsImage,
                        width: w * .9,
                        fit: BoxFit.cover,
                      )
                    ],
                  ),
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
                    navigatePageView(pageController: _pageController);
                  },
                  color: Color.lerp(beginColor, endColor, progress),
                ))
          ],
        ),
      ),
    );
  }
}
