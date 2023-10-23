import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fun_adventure/cores/utils/screen_dimentions.dart';
import 'package:fun_adventure/features/home/presentation/view/widgets/home_screen_widgets/button_navegation_bar_item.dart';
import 'package:fun_adventure/features/home/presentation/view/widgets/home_screen_widgets/custom_menu.dart';
import 'package:fun_adventure/features/home/presentation/view/widgets/home_screen_widgets/main_screen_menu.dart';
import 'package:fun_adventure/features/home/presentation/view_model/home_cubit/app_main_screen_cubit.dart';

import '../../../../../../cores/utils/images.dart';
import '../../../view_model/home_cubit/app_main_screen_states.dart';

class AppMainScreenWidget extends StatefulWidget {
  const AppMainScreenWidget({super.key});

  @override
  State<AppMainScreenWidget> createState() => _AppMainScreenState();
}

class _AppMainScreenState extends State<AppMainScreenWidget> {
  CustomMenuApp customMenuApp = CustomMenuApp();

  List<IconData> bottomNavigationBarIcons = [
    FontAwesomeIcons.house,
    FontAwesomeIcons.rocketchat,
    FontAwesomeIcons.magnifyingGlass,
    FontAwesomeIcons.plus,
  ];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    initInternetConnectionCubitObject();
    customMenuApp.initMenuValue();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppMainScreenCubit, AppMainScreenStates>(
      builder: (context, state) {
        AppMainScreenCubit appMainScreenCubit = AppMainScreenCubit.get(context);

        return Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(ImagesClass.homeBgPngImage),
                fit: BoxFit.fill),
          ),
          child: GestureDetector(
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
                          child: Stack(
                            children: [
                              appMainScreenCubit
                                  .screens[appMainScreenCubit.currentIndex],
                              Padding(
                                padding: const EdgeInsets.only(bottom: 20.0),
                                child: Align(
                                  alignment: Alignment.bottomCenter,
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(20)),
                                    child: BackdropFilter(
                                      filter: ImageFilter.blur(
                                          sigmaY: 5, sigmaX: 5),
                                      child: Container(
                                        height: context.height * .07,
                                        width: context.width * .6,
                                        decoration: BoxDecoration(
                                            color: const Color(0xff313745)
                                                .withOpacity(.8),
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(20))),
                                        child: ListView.builder(
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            scrollDirection: Axis.horizontal,
                                            itemBuilder: (context, index) =>
                                                CustomBottomNavigationBarItem(
                                                  icon:
                                                      bottomNavigationBarIcons[
                                                          index],
                                                  index: index,
                                                  currentIndex:
                                                      appMainScreenCubit
                                                          .currentIndex,
                                                  onTap: () {
                                                    appMainScreenCubit
                                                        .changeBottomNavigationBarIndex(
                                                            index);
                                                  },
                                                ),
                                            itemCount: 4),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
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
                      transform: Matrix4.translationValues(
                          customMenuApp.xPosition, 0, 0),
                      // Use translation instead of Offset for AnimatedContainer
                      width: context.width * .7,
                      child: const MainScreenMenu(),
                    )
                  ],
                )
              ],
            ),
          ),
        );
      },
      listener: (context, state) {},
    );
  }

  void initInternetConnectionCubitObject() {
    BlocProvider.of<AppMainScreenCubit>(context)
        .internetConnection
        .initCubitObject(BlocProvider.of<AppMainScreenCubit>(context));
  }
}
