import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fun_adventure/cores/utils/catched_image.dart';
import 'package:fun_adventure/cores/utils/color_degree.dart';
import 'package:fun_adventure/cores/utils/routers.dart';
import 'package:fun_adventure/cores/utils/screen_dimentions.dart';
import 'package:fun_adventure/features/home/presentation/view/widgets/sliver_sizedbox.dart';
import 'package:fun_adventure/features/home/presentation/view_model/home_screen_cubit/home_screen_cubit.dart';
import 'package:fun_adventure/features/home/presentation/view_model/home_screen_cubit/home_screen_states.dart';
import 'package:fun_adventure/features/home/presentation/view_model/main_screen_cubit/main_screen_cubit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../../../../../../cores/utils/custom_banner.dart';
import '../../../../../../../../../cores/utils/images.dart';
import '../../../../../../../../../cores/utils/locator_manger.dart';
import '../../../../../view_model/recent_news_banner_provider/recent_news_banner_provider.dart';
import '../../custom_appbar.dart';
import '../../custom_header.dart';
import '../../slider_banner.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeScreenCubit, HomeScreenStates>(
        builder: (context, state) {
      HomeScreenCubit homeScreenCubit = HomeScreenCubit.get(context);
      return TweenAnimationBuilder(
          tween: Tween<double>(begin: 0, end: 1),
          duration: const Duration(seconds: 1),
          builder: (_, value, __) {
            return Opacity(
              opacity: value,
              child: Scaffold(
                backgroundColor: Colors.transparent,
                body: SafeArea(
                  child: CustomScrollView(
                    slivers: [
                      CustomAppBar(
                        locationAction: homeScreenCubit.getUserLocation,
                        notificationAction: () async {},
                        locationName:
                            LocatorManager.locator<AppMainScreenCubit>()
                                .userLocation
                                .locationName,
                      ),
                      const SliverSizedBox(
                        h: 20,
                      ),
                      SliverGrid(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                          childAspectRatio: 1.4,
                        ),
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  RoutersClass.travelsScreen,
                                );
                              },
                              child: Card(
                                // generate blues with random shades
                                color: Colors.amber[Random().nextInt(9) * 100],
                                child: Stack(
                                  children: [
                                    CachedImage(
                                        networkImageUrl: homeScreenCubit
                                            .categoriesImagesUrl[index],
                                        assetImageUrl:
                                            ImagesClass.logoSvgImage),
                                    Align(
                                      alignment: Alignment.bottomCenter,
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: Colors.indigo
                                                .withOpacity(.7)
                                                .withLightness(.35),
                                            borderRadius:
                                                const BorderRadius.only(
                                              bottomRight: Radius.circular(10),
                                              bottomLeft: Radius.circular(10),
                                            )),
                                        width: context.width,
                                        child: Text(
                                          homeScreenCubit
                                              .categoriesTitles[index],
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.abel().copyWith(
                                              color: Colors.white
                                                  .withLightness(.9),
                                              fontWeight: FontWeight.w600,
                                              fontSize: 20.sp),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                          childCount: 4,
                        ),
                      ),
                      const SliverSizedBox(
                        h: 20,
                      ),
                      CustomHomeHeader(
                        h: context.height * .05,
                        w: context.width * .39,
                        header: 'Hot Travels',
                      ),
                      const SliverSizedBox(
                        h: 15,
                      ),
                      SliverToBoxAdapter(
                        child: HotTravelsSliderBanner(
                          height: context.height * .33,
                          action: (index, __) {
                            setState(() {
                              homeScreenCubit.sliderBannerCurrentIndex = index;
                            });
                          },
                          items: LocatorManager.locator<AppMainScreenCubit>()
                              .hotTravels,
                          scrollDirection: Axis.horizontal,
                        ),
                      ),
                      const SliverSizedBox(
                        h: 10,
                      ),
                      SliverToBoxAdapter(
                        child: Align(
                          alignment: Alignment.center,
                          child: AnimatedSmoothIndicator(
                            activeIndex:
                                homeScreenCubit.sliderBannerCurrentIndex,
                            count: 5,
                            effect: const WormEffect(dotHeight: 5),
                          ),
                        ),
                      ),
                      SliverSizedBox(
                        h: context.height * .03,
                      ),
                      CustomHomeHeader(
                        h: context.height * .05,
                        w: context.width * .403,
                        header: 'Recent News',
                      ),
                      SliverSizedBox(
                        h: context.height * .015,
                      ),
                      ChangeNotifierProvider(
                          create: (context) => RecentNewsBannerProvider(),
                          child: Consumer<RecentNewsBannerProvider>(builder:
                              (BuildContext context,
                                  RecentNewsBannerProvider model,
                                  Widget? child) {
                            return CustomRecentNewsBanner(
                              image:
                                  LocatorManager.locator<AppMainScreenCubit>()
                                      .recentNews[model.currentItem]
                                      .image,
                              title:
                                  LocatorManager.locator<AppMainScreenCubit>()
                                      .recentNews[model.currentItem]
                                      .title,
                              model: model,
                            );
                          })),
                      SliverSizedBox(
                        h: context.height * .11,
                      ),
                    ],
                  ),
                ),
              ),
            );
          });
    });
  }
}
