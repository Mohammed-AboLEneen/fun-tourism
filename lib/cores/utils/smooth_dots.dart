import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class SmoothPageDots extends StatelessWidget {
  final PageController pageController;

  const SmoothPageDots({super.key, required this.pageController});

  @override
  Widget build(BuildContext context) {
    return SmoothPageIndicator(
      controller: pageController,
      count: 3,
      axisDirection: Axis.horizontal,
      effect: ExpandingDotsEffect(
          spacing: 8.0,
          strokeWidth: 2,
          dotHeight: 7,
          dotColor: Colors.black,
          activeDotColor: Colors.black.withOpacity(.7)),
    );
  }
}
