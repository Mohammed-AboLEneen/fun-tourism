import 'package:flutter/cupertino.dart';

void navigatePageView({required PageController pageController}) {
  pageController.nextPage(
      duration: const Duration(milliseconds: 700), curve: Curves.easeInQuint);
}
