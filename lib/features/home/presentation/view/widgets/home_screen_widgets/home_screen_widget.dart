import 'package:flutter/material.dart';
import 'package:fun_adventure/cores/utils/screen_dimentions.dart';
import 'package:fun_adventure/features/home/presentation/view/widgets/sliver_sizedbox.dart';
import 'package:fun_adventure/features/home/presentation/view_model/home_cubit/app_main_screen_cubit.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../view_model/tops_banner_provider/recent_news_banner_provider.dart';
import '../custom_appbar.dart';
import 'banner_slider.dart';
import 'custom_banner.dart';
import 'custom_header.dart';
import 'custom_menu.dart';
import 'main_screen_menu.dart';

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
                              h: context.height * .12,
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
                child: const MainScreenMenu(),
              )
            ],
          )
        ],
      ),
    );
  }
}
