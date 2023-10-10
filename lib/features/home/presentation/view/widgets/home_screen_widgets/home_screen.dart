import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fun_adventure/constants.dart';
import 'package:fun_adventure/cores/models/recent_news_model/recent_news_model.dart';
import 'package:fun_adventure/cores/utils/screen_dimentions.dart';
import 'package:fun_adventure/features/home/presentation/view/widgets/home_screen_widgets/top_banner_item_clippath.dart';
import 'package:fun_adventure/features/home/presentation/view/widgets/home_screen_widgets/top_banner_item_textbutton.dart';
import 'package:fun_adventure/features/home/presentation/view/widgets/home_screen_widgets/travel_card.dart';
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
                                        Container(
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  image: NetworkImage(locator
                                                          .isRegistered<
                                                              List<
                                                                  RecentNewsModel>>()
                                                      ? (locator<List<RecentNewsModel>>()[
                                                                  model
                                                                      .currentItem]
                                                              .image ??
                                                          '')
                                                      : 'https://th.bing.com/th/id/OIP.7wO0lin122XZz8cW6QwMPwHaNK?pid=ImgDet&rs=1'),
                                                  fit: BoxFit.cover),
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(20))),
                                        ),
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
                                              locator.isRegistered<
                                                      List<RecentNewsModel>>()
                                                  ? (locator<List<RecentNewsModel>>()[
                                                              model.currentItem]
                                                          .title ??
                                                      '')
                                                  : 'lolo popo',
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
