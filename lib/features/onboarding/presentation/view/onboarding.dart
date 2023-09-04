import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fun_adventure/cores/utils/images.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({super.key});

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage>
    with SingleTickerProviderStateMixin {
  late PageController _pageController;
  double progress = 0;

  Color? beginColor = const Color(0xffdad4c8);
  Color? endColor = const Color(0xffffe5de);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _pageController = PageController()
      ..addListener(() {
        setState(() {
          progress = _pageController.page ?? 0;

          if (progress > 1) {
            beginColor = const Color(0xffffe5de);
            endColor = const Color(0xffdbf6e5).withOpacity(.9);
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
              bottom: h * .2,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: w * .15),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  constraints: BoxConstraints(maxWidth: w * .73),
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
                          height: 20,
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
                  padding: EdgeInsets.only(bottom: h * .3),
                  child: Stack(
                    alignment: Alignment.center,
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
          ],
        ),
      ),
    );
  }
}
