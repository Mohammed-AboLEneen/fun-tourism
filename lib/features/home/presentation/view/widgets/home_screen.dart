import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fun_adventure/cores/utils/screen_dimentions.dart';
import 'package:fun_adventure/features/home/presentation/view/widgets/banner_slider.dart';
import 'package:fun_adventure/features/home/presentation/view/widgets/top_banner_item_clippath.dart';
import 'package:fun_adventure/features/home/presentation/view/widgets/tops_banner_item.dart';
import 'package:fun_adventure/features/home/presentation/view/widgets/travel_card.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../../cores/utils/images.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int sliderBannerCurrentIndex = 0;
  int bottomNavigationCurrentIndex = 0;

  List<IconData> bottomNavigationBarIcons = [
    FontAwesomeIcons.house,
    FontAwesomeIcons.rocketchat,
    FontAwesomeIcons.magnifyingGlass,
    FontAwesomeIcons.plus,
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          flexibleSpace: FlexibleSpaceBar(
            title: Text(
              'FunTourism',
              style: GoogleFonts.actor(),
            ),
          ),
          backgroundColor: Colors.white.withOpacity(.4),
          actions: [
            IconButton(
                onPressed: () {}, icon: const FaIcon(FontAwesomeIcons.bell)),
          ],
          pinned: true,
          floating: true,
          snap: true,
        ),
        SliverToBoxAdapter(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                  height: context.height * .3,
                  child: Stack(
                    children: [
                      SizedBox(
                        width: context.width,
                        height: context.height * .3,
                        child: const Card(
                          color: Colors.white,
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: SizedBox(
                          width: context.width * .7,
                          height: context.height * .28,
                          child: SvgPicture.asset(
                            ImagesClass.homeWelcomeSvgImage,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: SizedBox(
                          height: context.height * .27,
                          width: context.width * .3,
                          child: Text('Have Fun & Enjoy',
                              style: GoogleFonts.tajawal(fontSize: 32.sp)),
                        ),
                      )
                    ],
                  ))
            ],
          ),
        ),
        const SliverToBoxAdapter(
          child: SizedBox(
            height: 20,
          ),
        ),
        SliverToBoxAdapter(
          child: SliderBanner(
            height: context.height * .33,
            action: (index, __) {
              setState(() {
                sliderBannerCurrentIndex = index;
              });
            },
            item: const TravelsCard(),
            scrollDirection: Axis.horizontal,
          ),
        ),
        const SliverToBoxAdapter(
          child: SizedBox(
            height: 10,
          ),
        ),
        SliverToBoxAdapter(
          child: Align(
            alignment: Alignment.center,
            child: AnimatedSmoothIndicator(
              activeIndex: sliderBannerCurrentIndex,
              count: 5,
              effect: const WormEffect(dotHeight: 5),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: SizedBox(
            height: context.height * .02,
          ),
        ),
        SliverToBoxAdapter(
          child: SizedBox(
            height: context.height * .01,
          ),
        ),
        SliverToBoxAdapter(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: SizedBox(
            height: context.height * .3,
            child: Stack(
              children: [
                PageView(
                  children: const [
                    TopBannerItem(
                      imageUrl:
                          'https://th.bing.com/th/id/OIP.tOjEWXEWnWixb4waOSzNdwHaE8?pid=ImgDet&rs=1',
                      title: 'There Is New Something',
                      subTitle: 'lolo is true power hhh',
                    ),
                    TopBannerItem(
                      imageUrl:
                          'https://th.bing.com/th/id/OIP.tOjEWXEWnWixb4waOSzNdwHaE8?pid=ImgDet&rs=1',
                      title: 'There Is New Something',
                      subTitle: 'lolo is true power hhh',
                    ),
                    TopBannerItem(
                      imageUrl:
                          'https://th.bing.com/th/id/OIP.tOjEWXEWnWixb4waOSzNdwHaE8?pid=ImgDet&rs=1',
                      title: 'There Is New Something',
                      subTitle: 'lolo is true power hhh',
                    ),
                    TopBannerItem(
                      imageUrl:
                          'https://th.bing.com/th/id/OIP.tOjEWXEWnWixb4waOSzNdwHaE8?pid=ImgDet&rs=1',
                      title: 'There Is New Something',
                      subTitle: 'lolo is true power hhh',
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Stack(children: [
                    ClipPath(
                      clipper: MyCustomClipper(),
                      child: Container(
                        height: context.height * .1,
                        width: context.width,
                        decoration: const BoxDecoration(
                            gradient: LinearGradient(
                                colors: [Colors.transparent, Colors.indigo]),
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 5.0),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 10.0),
                                  child: AnimatedSmoothIndicator(
                                    activeIndex: sliderBannerCurrentIndex,
                                    count: 5,
                                    effect: const ColorTransitionEffect(
                                        dotHeight: 10,
                                        dotWidth: 10,
                                        dotColor: Colors.grey,
                                        activeDotColor: Colors.indigo),
                                  ),
                                ),
                                SizedBox(
                                  width: context.width * .17,
                                ),
                                SizedBox(
                                  width: context.width * .5,
                                  child: Text(
                                    'New Park In Cairo',
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
                )
              ],
            ),
          ),
        )),
        SliverToBoxAdapter(
          child: SizedBox(
            height: context.height * .13,
          ),
        ),
      ],
    );
  }
}
