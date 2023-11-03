import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fun_adventure/cores/utils/catched_image.dart';
import 'package:fun_adventure/cores/utils/color_degree.dart';
import 'package:fun_adventure/cores/utils/screen_dimentions.dart';
import 'package:fun_adventure/cores/utils/wating_screen.dart';
import 'package:fun_adventure/features/home/presentation/view/widgets/home_screen_widgets/home_screen_menu_structure.dart';
import 'package:fun_adventure/features/home/presentation/view/widgets/sliver_sizedbox.dart';
import 'package:fun_adventure/features/home/presentation/view_model/main_screen_cubit/main_screen_cubit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../../../constants.dart';
import '../../../../../../cores/utils/images.dart';
import '../../../../../../cores/utils/locator_manger.dart';
import '../../../view_model/home_screen_cubit/home_screen_cubit.dart';
import '../../../view_model/home_screen_cubit/home_screen_states.dart';
import '../../../view_model/recent_news_banner_provider/recent_news_banner_provider.dart';
import 'custom_appbar.dart';
import 'custom_banner.dart';
import 'custom_header.dart';
import 'custom_menu_manger.dart';
import 'notification_screen.dart';
import 'notification_screen_ui_manger.dart';
import 'slider_banner.dart';

class HomeScreenWidget extends StatefulWidget {
  const HomeScreenWidget({super.key});

  @override
  State<HomeScreenWidget> createState() => _HomeScreenWidgetState();
}

class _HomeScreenWidgetState extends State<HomeScreenWidget>
    with SingleTickerProviderStateMixin {
  int sliderBannerCurrentIndex = 0;
  double notification = 0;

  NotificationsScreenUiManger notificationsScreenUiManger =
      NotificationsScreenUiManger();
  MangeCustomMenuApp mangeCustomMenuApp = MangeCustomMenuApp();

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
    mangeCustomMenuApp.initMenuValue();
  }

  @override
  Widget build(BuildContext context) {
    // this BlocConsumer to listen the internet connection status change
    return BlocConsumer<HomeScreenCubit, HomeScreenStates>(
        builder: (context, state) {
          HomeScreenCubit homeScreenCubit = HomeScreenCubit.get(context);

          return LocatorManager.locator<AppMainScreenCubit>()
                      .recentNews
                      .isNotEmpty ||
                  LocatorManager.locator<AppMainScreenCubit>()
                      .hotTravels
                      .isNotEmpty
              ? Stack(
                  children: [
                    GestureDetector(
                      onPanUpdate: (tapInfo) {
                        setState(() {
                          mangeCustomMenuApp.realTimeUpdatingValues(
                              context, tapInfo);
                        });
                      },
                      onPanEnd: (de) {
                        mangeCustomMenuApp.leaveMenuMoving(context);
                        setState(() {});
                      },
                      child: TweenAnimationBuilder(
                          tween: Tween<double>(begin: 0, end: 1),
                          duration: const Duration(milliseconds: 1000),
                          builder: (_, value, ___) {
                            return Opacity(
                              opacity: value,
                              child: Stack(
                                children: [
                                  TweenAnimationBuilder(
                                      tween: Tween<double>(
                                          begin: mangeCustomMenuApp
                                              .tweenBeginScale,
                                          end:
                                              mangeCustomMenuApp.tweenEndScale),
                                      duration:
                                          const Duration(milliseconds: 150),
                                      builder: (_, value, ___) {
                                        return Transform.scale(
                                            scale: (1 - value),
                                            child: RefreshIndicator(
                                              onRefresh: () async {
                                                homeScreenCubit
                                                    .clearHomeScreenData();
                                                homeScreenCubit.getData(uId!);
                                              },
                                              child: Scaffold(
                                                backgroundColor:
                                                    Colors.transparent,
                                                body: SafeArea(
                                                  child: CustomScrollView(
                                                    slivers: [
                                                      CustomAppBar(
                                                        locationAction: () {
                                                          homeScreenCubit
                                                              .getUserLocation();
                                                        },
                                                        menuAction: () {
                                                          setState(() {
                                                            mangeCustomMenuApp
                                                                .openMenu();
                                                          });
                                                        },
                                                        notificationAction:
                                                            () async {
                                                          setState(() {
                                                            notificationsScreenUiManger
                                                                .openNotificationScreen(
                                                                    context);
                                                          });
                                                        },
                                                        locationName:
                                                            LocatorManager.locator<
                                                                    AppMainScreenCubit>()
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
                                                        delegate:
                                                            SliverChildBuilderDelegate(
                                                          (context, index) {
                                                            return Card(
                                                              // generate blues with random shades
                                                              color: Colors
                                                                  .amber[Random()
                                                                      .nextInt(
                                                                          9) *
                                                                  100],
                                                              child: Stack(
                                                                children: [
                                                                  CachedImage(
                                                                      networkImageUrl:
                                                                          categoriesImagesUrl[
                                                                              index],
                                                                      assetImageUrl:
                                                                          ImagesClass
                                                                              .logoSvgImage),
                                                                  Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .bottomCenter,
                                                                    child:
                                                                        Container(
                                                                      decoration: BoxDecoration(
                                                                          color: Colors.indigo.withOpacity(.7).withLightness(.35),
                                                                          borderRadius: const BorderRadius.only(
                                                                            bottomRight:
                                                                                Radius.circular(10),
                                                                            bottomLeft:
                                                                                Radius.circular(10),
                                                                          )),
                                                                      width: context
                                                                          .width,
                                                                      child:
                                                                          Text(
                                                                        categoriesTitles[
                                                                            index],
                                                                        textAlign:
                                                                            TextAlign.center,
                                                                        style: GoogleFonts.abel().copyWith(
                                                                            color:
                                                                                Colors.white.withLightness(.9),
                                                                            fontWeight: FontWeight.w600,
                                                                            fontSize: 20.sp),
                                                                      ),
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
                                                          height:
                                                              context.height *
                                                                  .33,
                                                          action: (index, __) {
                                                            setState(() {
                                                              sliderBannerCurrentIndex =
                                                                  index;
                                                            });
                                                          },
                                                          items: LocatorManager
                                                                  .locator<
                                                                      AppMainScreenCubit>()
                                                              .hotTravels,
                                                          scrollDirection:
                                                              Axis.horizontal,
                                                        ),
                                                      ),
                                                      const SliverSizedBox(
                                                        h: 10,
                                                      ),
                                                      SliverToBoxAdapter(
                                                        child: Align(
                                                          alignment:
                                                              Alignment.center,
                                                          child:
                                                              AnimatedSmoothIndicator(
                                                            activeIndex:
                                                                sliderBannerCurrentIndex,
                                                            count: 5,
                                                            effect:
                                                                const WormEffect(
                                                                    dotHeight:
                                                                        5),
                                                          ),
                                                        ),
                                                      ),
                                                      SliverSizedBox(
                                                        h: context.height * .03,
                                                      ),
                                                      CustomHomeHeader(
                                                        h: context.height * .05,
                                                        w: context.width * .38,
                                                        header: 'Recent News',
                                                      ),
                                                      SliverSizedBox(
                                                        h: context.height *
                                                            .015,
                                                      ),
                                                      ChangeNotifierProvider(
                                                          create: (context) =>
                                                              RecentNewsBannerProvider(),
                                                          child: Consumer<
                                                                  RecentNewsBannerProvider>(
                                                              builder: (BuildContext
                                                                      context,
                                                                  RecentNewsBannerProvider
                                                                      model,
                                                                  Widget?
                                                                      child) {
                                                            return CustomRecentNewsBanner(
                                                              image: LocatorManager
                                                                      .locator<
                                                                          AppMainScreenCubit>()
                                                                  .recentNews[model
                                                                      .currentItem]
                                                                  .image,
                                                              title: LocatorManager
                                                                      .locator<
                                                                          AppMainScreenCubit>()
                                                                  .recentNews[model
                                                                      .currentItem]
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
                                            ));
                                      }),
                                  HomeScreenMenuStructure(
                                    tBeginColor:
                                        mangeCustomMenuApp.tweenBeginColor,
                                    tEndColor: mangeCustomMenuApp.tweenEndColor,
                                    normalizedXPosition:
                                        mangeCustomMenuApp.normalizedXPosition,
                                    xPosition: mangeCustomMenuApp.xPosition,
                                    onTapBlackBackGround: () {
                                      setState(() {
                                        mangeCustomMenuApp.closeMenu(context);
                                      });
                                    },
                                  ),
                                ],
                              ),
                            );
                          }),
                    ),
                    NotificationScreen(
                      notificationsScreenUiManger: notificationsScreenUiManger,
                      onTapBlackContainer: () {
                        setState(() {
                          notificationsScreenUiManger
                              .closeNotificationScreen(context);
                        });
                      },
                      animatedContainerOnEndMethod: () {
                        setState(() {
                          if (notificationsScreenUiManger
                                  .notificationScreenHeight ==
                              context.height * .75) {
                            notificationsScreenUiManger
                                .setTheNotificationsScreenBodyVisibility(true);
                          }
                        });
                      },
                    )
                  ],
                )
              : WaitingScreen(
                  action: () {
                    homeScreenCubit.getData(uId!);
                  },
                );
        },
        listener: (context, state) {});
  }
}
