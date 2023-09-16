import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';

import '../home_page.dart';

class SliderBanner extends StatelessWidget {
  const SliderBanner({super.key});

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;

    return CarouselSlider.builder(
      options: CarouselOptions(
        height: h * .33,
        aspectRatio: 16 / 9,
        viewportFraction: 0.8,
        initialPage: 0,
        enableInfiniteScroll: true,
        reverse: false,
        autoPlayCurve: Curves.fastOutSlowIn,
        enlargeCenterPage: true,
        enlargeFactor: 0.25,
        scrollDirection: Axis.horizontal,
      ),
      itemCount: 5,
      itemBuilder: (BuildContext context, int index, int realIndex) {
        return TravelsCards();
      },
    );
  }
}
