import 'package:carousel_slider/carousel_options.dart';
import 'package:flutter/cupertino.dart';

CarouselOptions carouselOptions(context, double h) {
  return CarouselOptions(
    height: h * .33,
    aspectRatio: 16 / 9,
    viewportFraction: .8,
    initialPage: 0,
    enableInfiniteScroll: true,
    reverse: false,
    autoPlayCurve: Curves.fastOutSlowIn,
    enlargeCenterPage: true,
    enlargeFactor: 0.25,
    scrollDirection: Axis.horizontal,
  );
}
