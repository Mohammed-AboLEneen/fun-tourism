import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fun_adventure/features/home/presentation/view/widgets/banner_slider.dart';
import 'package:fun_adventure/features/home/presentation/view/widgets/home_page_menu.dart';
import 'package:fun_adventure/features/home/presentation/view/widgets/travel_card.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../cores/utils/images.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    return Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(ImagesClass.homeBgPngImage), fit: BoxFit.fill),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          drawer: const HomeMenu(),
          body: CustomScrollView(
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
                      onPressed: () {},
                      icon: const FaIcon(FontAwesomeIcons.bell)),
                  IconButton(
                      onPressed: () {},
                      icon: const FaIcon(FontAwesomeIcons.magnifyingGlass))
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
                        height: h * .3,
                        child: Stack(
                          children: [
                            SizedBox(
                              width: w,
                              height: h * .3,
                              child: const Card(
                                color: Colors.white,
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: SizedBox(
                                width: w * .7,
                                height: h * .28,
                                child: SvgPicture.asset(
                                  ImagesClass.homeWelcomeSvgImage,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: SizedBox(
                                height: h * .27,
                                width: w * .3,
                                child: Text('Have Fun & Enjoy',
                                    style:
                                        GoogleFonts.tajawal(fontSize: 32.sp)),
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
                  height: h * .33,
                  action: (index, __) {
                    setState(() {
                      currentIndex = index;
                    });
                  },
                  item: const TravelsCard(),
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
                    activeIndex: currentIndex,
                    count: 5,
                    effect: const WormEffect(dotHeight: 5),
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
