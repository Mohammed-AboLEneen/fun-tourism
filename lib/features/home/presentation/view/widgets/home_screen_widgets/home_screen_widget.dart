import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fun_adventure/cores/utils/catched_image.dart';
import 'package:fun_adventure/cores/utils/screen_dimentions.dart';
import 'package:fun_adventure/features/home/presentation/view/widgets/sliver_sizedbox.dart';
import 'package:fun_adventure/features/home/presentation/view_model/home_cubit/app_main_screen_cubit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../../../cores/utils/images.dart';
import '../../../view_model/tops_banner_provider/recent_news_banner_provider.dart';
import '../custom_appbar.dart';
import 'custom_banner.dart';
import 'custom_header.dart';
import 'custom_menu.dart';
import 'home_screen_menu_item.dart';
import 'slider_banner.dart';

class HomeScreenWidget extends StatefulWidget {
  final AppMainScreenCubit appMainScreenCubit;

  const HomeScreenWidget({super.key, required this.appMainScreenCubit});

  @override
  State<HomeScreenWidget> createState() => _HomeScreenWidgetState();
}

class _HomeScreenWidgetState extends State<HomeScreenWidget>
    with SingleTickerProviderStateMixin {
  int sliderBannerCurrentIndex = 0;
  CustomMenuApp customMenuApp = CustomMenuApp();

  List<String> categoriesTitles = [
    'North Egypt',
    'South Egypt',
    'East Egypt',
    'West Egypt',
  ];

  List<String> categoriesImagesUrl = [
    'https://th.bing.com/th/id/R.fce7404b15d00c3020f7eecdc5313836?rik=V8qh4TWh8NXp9w&pid=ImgRaw&r=0',
    'https://th.bing.com/th/id/R.0d23e67eabbb6c0f6a9e5fa7ad950a31?rik=gqXlAoKzqQl78w&pid=ImgRaw&r=0',
    'https://th.bing.com/th/id/OIP.RBRql-XKiGpHsGAMoCQ7-AHaCe?pid=ImgDet&rs=1',
    'https://www.tripsavvy.com/thmb/Ue5Tz-4fTb9OTBbEzBxlqa8UT_s=/2143x1399/filters:no_upscale():max_bytes(150000):strip_icc()/GettyImages-154260931-584169ec3df78c0230514c82.jpg',
  ];

  @override
  void initState() {
    super.initState();
    customMenuApp.initMenuValue();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: (tapInfo) {
        setState(() {
          customMenuApp.realTimeUpdatingValues(context, tapInfo);
        });
      },
      onPanEnd: (de) {
        customMenuApp.leaveMenuMoving(context);
        setState(() {});
      },
      child: Stack(
        children: [
          TweenAnimationBuilder(
              tween: Tween<double>(
                  begin: customMenuApp.tweenBeginScale,
                  end: customMenuApp.tweenEndScale),
              duration: const Duration(milliseconds: 150),
              builder: (_, value, ___) {
                return Transform.scale(
                    scale: (1 - value),
                    child: Scaffold(
                      backgroundColor: Colors.transparent,
                      body: SafeArea(
                        child: CustomScrollView(
                          slivers: [
                            CustomAppBar(
                              locationAction: () {
                                widget.appMainScreenCubit.getUserLocation();
                              },
                              menuAction: () {
                                setState(() {
                                  customMenuApp.openMenu();
                                });
                              },
                              locationName: widget
                                  .appMainScreenCubit.userLocation.locationName,
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
                                  return Card(
                                    // generate blues with random shades
                                    color:
                                        Colors.amber[Random().nextInt(9) * 100],
                                    child: Stack(
                                      children: [
                                        CachedImage(
                                            networkImageUrl:
                                                categoriesImagesUrl[index],
                                            assetImageUrl:
                                                ImagesClass.logoSvgImage),
                                        Container(
                                          alignment: Alignment.bottomCenter,
                                          margin:
                                              const EdgeInsets.only(bottom: 5),
                                          child: Text(
                                            categoriesTitles[index],
                                            style: GoogleFonts.abel().copyWith(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 20.sp),
                                          ),
                                        ),
                                      ],
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
                              w: context.width * .33,
                              header: 'Hot Travels',
                            ),
                            const SliverSizedBox(
                              h: 15,
                            ),
                            SliverToBoxAdapter(
                              child: SliderBanner(
                                height: context.height * .33,
                                action: (index, __) {
                                  setState(() {
                                    sliderBannerCurrentIndex = index;
                                  });
                                },
                                items: widget.appMainScreenCubit.hotTravels,
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
                                  activeIndex: sliderBannerCurrentIndex,
                                  count: 5,
                                  effect: const WormEffect(dotHeight: 5),
                                ),
                              ),
                            ),
                            SliverSizedBox(
                              h: context.height * .05,
                            ),
                            CustomHomeHeader(
                              h: context.height * .05,
                              w: context.width * .38,
                              header: 'Recent News',
                            ),
                            SliverSizedBox(
                              h: context.height * .015,
                            ),
                            ChangeNotifierProvider(
                                create: (context) => RecentNewsBannerProvider(),
                                child: Consumer<RecentNewsBannerProvider>(
                                    builder: (BuildContext context,
                                        RecentNewsBannerProvider model,
                                        Widget? child) {
                                  return CustomRecentNewsBanner(
                                    image: widget.appMainScreenCubit
                                        .recentNews[model.currentItem].image,
                                    title: widget.appMainScreenCubit
                                        .recentNews[model.currentItem].title,
                                    model: model,
                                  );
                                })),
                            SliverSizedBox(
                              h: context.height * .11,
                            ),
                          ],
                        ),
                      ),
                    ));
              }),
          Stack(
            children: [
              if (customMenuApp.normalizedXPosition < 1)
                GestureDetector(
                  onTap: () {
                    customMenuApp.closeMenu(context);
                    setState(() {});
                  },
                  child: TweenAnimationBuilder(
                      tween: Tween<double>(
                          begin: customMenuApp.tweenBeginColor,
                          end: customMenuApp.tweenEndColor),
                      duration: const Duration(milliseconds: 300),
                      builder: (_, value, ___) {
                        if (value < 0) {
                          value = 0;
                        }
                        return Container(
                          width: context.width,
                          height: context.height,
                          color: Colors.black.withOpacity(value),
                        );
                      }),
                ),
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                // Set the duration for the animation
                curve: Curves.easeOut,
                // Set the easing function for the animation
                transform:
                    Matrix4.translationValues(customMenuApp.xPosition, 0, 0),
                // Use translation instead of Offset for AnimatedContainer
                width: context.width * .7,
                child: const HomeScreenMenu(),
              )
            ],
          )
        ],
      ),
    );
  }
}
