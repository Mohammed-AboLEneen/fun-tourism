import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';

class SliderBanner extends StatelessWidget {
  final double height;
  final Widget item;
  final Axis scrollDirection;
  final CarouselController? controller;
  final dynamic Function(int, CarouselPageChangedReason)? action;

  const SliderBanner({
    super.key,
    required this.height,
    required this.item,
    this.controller,
    this.action,
    required this.scrollDirection,
  });

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      carouselController: controller,
      options: CarouselOptions(
          height: height,
          viewportFraction: 0.8,
          initialPage: 0,
          enableInfiniteScroll: true,
          reverse: false,
          enlargeCenterPage: true,
          enlargeFactor: 0.28,
          scrollDirection: Axis.horizontal,
          onPageChanged: action),
      itemCount: 5,
      itemBuilder: (BuildContext context, int index, int realIndex) {
        return item;
      },
    );
  }
}
