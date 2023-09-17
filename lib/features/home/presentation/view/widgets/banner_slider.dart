import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';

class SliderBanner extends StatelessWidget {
  final double height;
  final Widget item;
  final CarouselController? controller;
  final dynamic Function(int, CarouselPageChangedReason)? action;

  const SliderBanner(
      {super.key,
      required this.height,
      required this.item,
      this.controller,
      this.action});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      carouselController: controller,
      options: CarouselOptions(
          height: height,
          aspectRatio: 16 / 9,
          viewportFraction: 0.8,
          initialPage: 0,
          enableInfiniteScroll: true,
          reverse: false,
          autoPlayCurve: Curves.fastOutSlowIn,
          enlargeCenterPage: true,
          enlargeFactor: 0.25,
          scrollDirection: Axis.horizontal,
          onPageChanged: action),
      itemCount: 5,
      itemBuilder: (BuildContext context, int index, int realIndex) {
        return item;
      },
    );
  }
}
