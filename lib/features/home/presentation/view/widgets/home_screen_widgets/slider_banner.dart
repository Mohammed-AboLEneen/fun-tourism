import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:fun_adventure/cores/models/hot_travels_model/hot_travels_model.dart';
import 'package:fun_adventure/features/home/presentation/view/widgets/home_screen_widgets/hot_travel_card.dart';

class SliderBanner extends StatelessWidget {
  final double height;
  final List<HotTravelModel> items;
  final Axis scrollDirection;
  final CarouselController? controller;
  final dynamic Function(int, CarouselPageChangedReason)? action;

  const SliderBanner({
    super.key,
    required this.height,
    required this.items,
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
      itemCount: items.length,
      itemBuilder: (BuildContext context, int index, int realIndex) {
        return TravelsCard(hotTravelModel: items[index]);
      },
    );
  }
}
