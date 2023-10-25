import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:fun_adventure/constants.dart';
import 'package:fun_adventure/cores/utils/screen_dimentions.dart';
import 'package:fun_adventure/features/home/presentation/view/widgets/home_screen_widgets/recent_news__banner_title_clippath.dart';
import 'package:fun_adventure/features/home/presentation/view/widgets/home_screen_widgets/recent_news_banner_item_button.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../view_model/tops_banner_provider/recent_news_banner_provider.dart';

class CustomRecentNewsBanner extends StatelessWidget {
  final Uint8List? image;
  final String? title;
  final RecentNewsBannerProvider model;

  const CustomRecentNewsBanner(
      {super.key,
      required this.image,
      required this.title,
      required this.model});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
        child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: SizedBox(
        height: context.height * .3,
        child: Stack(
          children: [
            SizedBox(
                width: context.width,
                child: SizedBox(
                    width: context.width * .4,
                    height: context.height * .5,
                    child: Stack(alignment: Alignment.bottomCenter, children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.memory(
                          image ?? Uint8List(0),
                          fit: BoxFit.cover,
                          width: context.width,
                        ),
                      )
                    ]))),
            Align(
              alignment: Alignment.bottomCenter,
              child: Stack(children: [
                ClipPath(
                  clipper: RecentNewsBannerTitleClipper(),
                  child: Container(
                    height: context.height * .1,
                    width: context.width,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [Colors.transparent, mainColor]),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20))),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 5.0),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: AnimatedSmoothIndicator(
                                activeIndex: model.currentItem,
                                count: 4,
                                effect: ColorTransitionEffect(
                                    dotHeight: 10,
                                    dotWidth: 10,
                                    dotColor: Colors.white.withOpacity(0.7),
                                    activeDotColor: Colors.indigo),
                              ),
                            ),
                            SizedBox(
                              width: context.width * .17,
                            ),
                            Expanded(
                              child: Text(
                                title ?? 'Noting',
                                maxLines: 1,
                                style: GoogleFonts.bitter().copyWith(
                                    color: Colors.white.withOpacity(.8),
                                    overflow: TextOverflow.ellipsis,
                                    fontSize: context.height * .023),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ]),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: RecentNewsBannerItemButton(
                topLeft: Radius.zero,
                bottomLeft: Radius.zero,
                action: () {
                  model.previousTopsBannerItem();
                },
                icon: Icons.arrow_back,
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: RecentNewsBannerItemButton(
                topRight: Radius.zero,
                bottomRight: Radius.zero,
                action: () {
                  model.nextTopsBannerItem();
                },
                icon: Icons.arrow_forward_rounded,
              ),
            )
          ],
        ),
      ),
    ));
  }
}
