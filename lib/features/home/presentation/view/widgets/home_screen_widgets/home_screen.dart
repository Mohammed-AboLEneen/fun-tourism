import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fun_adventure/cores/utils/screen_dimentions.dart';
import 'package:fun_adventure/features/home/presentation/view/widgets/home_screen_widgets/top_banner_item_clippath.dart';
import 'package:fun_adventure/features/home/presentation/view/widgets/home_screen_widgets/top_banner_item_textbutton.dart';
import 'package:fun_adventure/features/home/presentation/view_model/home_cubit/app_main_screen_cubit.dart';
import 'package:fun_adventure/features/home/presentation/view_model/home_cubit/app_main_screen_states.dart';
import 'package:fun_adventure/features/home/presentation/view_model/tops_banner_provider/tops_banner_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../../../cores/utils/images.dart';
import 'banner_slider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int sliderBannerCurrentIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppMainScreenCubit, AppMainScreenStates>(
        builder: (context, state) {
          AppMainScreenCubit appMainScreenCubit =
              AppMainScreenCubit.get(context);

          return CustomScrollView(
            slivers: [
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
                child: Row(
                  children: [
                    ClipPath(
                      clipper: HotTravelContainerClipper(),
                      child: Container(
                        color: Colors.cyan,
                        height: context.height * .05,
                        width: context.width * .33,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 3.0.h, horizontal: 6.0.w),
                          child: Text(
                            'Hot Travels',
                            style: GoogleFonts.akayaKanadaka()
                                .copyWith(fontSize: context.height * .027),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SliverToBoxAdapter(
                child: SizedBox(
                  height: 15,
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
                  items: appMainScreenCubit.hotTravels,
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
                  height: context.height * .013,
                ),
              ),
              SliverToBoxAdapter(
                child: Row(
                  children: [
                    ClipPath(
                      clipper: HotTravelContainerClipper(),
                      child: Container(
                        color: Colors.cyan,
                        height: context.height * .05,
                        width: context.width * .37,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 3.0.h, horizontal: 6.0.w),
                          child: Text(
                            'Recent News',
                            style: GoogleFonts.akayaKanadaka()
                                .copyWith(fontSize: context.height * .027),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: context.height * .015,
                ),
              ),
              SliverToBoxAdapter(
                  child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: SizedBox(
                  height: context.height * .3,
                  child: ChangeNotifierProvider(
                    create: (BuildContext context) => TopsBannerProvider(),
                    child: Consumer<TopsBannerProvider>(builder:
                        (BuildContext context, TopsBannerProvider model,
                            Widget? child) {
                      return Stack(
                        children: [
                          SizedBox(
                              width: context.width,
                              child: SizedBox(
                                  width: context.width * .4,
                                  height: context.height * .5,
                                  child: Stack(
                                      alignment: Alignment.bottomCenter,
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          child: Image.memory(
                                            appMainScreenCubit
                                                    .recentNews[
                                                        model.currentItem]
                                                    .image ??
                                                Uint8List(0),
                                            fit: BoxFit.cover,
                                            width: context.width,
                                          ),
                                        )
                                      ]))),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Stack(children: [
                              ClipPath(
                                clipper: MyCustomClipper(),
                                child: Container(
                                  height: context.height * .1,
                                  width: context.width,
                                  decoration: const BoxDecoration(
                                      gradient: LinearGradient(colors: [
                                        Colors.transparent,
                                        Colors.indigo
                                      ]),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20))),
                                  child: Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 5.0),
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10.0),
                                            child: AnimatedSmoothIndicator(
                                              activeIndex: model.currentItem,
                                              count: 4,
                                              effect: ColorTransitionEffect(
                                                  dotHeight: 10,
                                                  dotWidth: 10,
                                                  dotColor: Colors.white
                                                      .withOpacity(0.7),
                                                  activeDotColor:
                                                      Colors.indigo),
                                            ),
                                          ),
                                          SizedBox(
                                            width: context.width * .17,
                                          ),
                                          Expanded(
                                            child: Text(
                                              appMainScreenCubit
                                                      .recentNews[
                                                          model.currentItem]
                                                      .title ??
                                                  'Noting',
                                              maxLines: 1,
                                              style: GoogleFonts.bitter()
                                                  .copyWith(
                                                      color: Colors.white
                                                          .withOpacity(.8),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      fontSize: context.height *
                                                          .023),
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
                            child: TopBannerItemTextButton(
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
                            child: TopBannerItemTextButton(
                              topRight: Radius.zero,
                              bottomRight: Radius.zero,
                              action: () {
                                model.nextTopsBannerItem();
                              },
                              icon: Icons.arrow_forward_rounded,
                            ),
                          )
                        ],
                      );
                    }),
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
        },
        listener: (context, state) {});
  }
}

class HotTravelContainerClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(size.width, 0);
    path.lineTo(size.width * .85, size.height * .5);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
