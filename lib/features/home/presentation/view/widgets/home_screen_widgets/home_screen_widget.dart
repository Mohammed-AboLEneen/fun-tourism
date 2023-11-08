import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fun_adventure/features/home/presentation/view/widgets/home_screen_widgets/home_menu/home_screen_menu_structure.dart';
import 'package:fun_adventure/features/home/presentation/view_model/main_screen_cubit/main_screen_cubit.dart';
import 'package:fun_adventure/features/home/presentation/view_model/menu_logic_provider/menu_logic_provider.dart';
import 'package:provider/provider.dart';

import '../../../../../../constants.dart';
import '../../../../../../cores/utils/locator_manger.dart';
import '../../../view_model/home_screen_cubit/home_screen_cubit.dart';
import '../../../view_model/home_screen_cubit/home_screen_states.dart';
import '../wating_screen.dart';

class HomeScreenWidget extends StatefulWidget {
  const HomeScreenWidget({super.key});

  @override
  State<HomeScreenWidget> createState() => _HomeScreenWidgetState();
}

class _HomeScreenWidgetState extends State<HomeScreenWidget>
    with SingleTickerProviderStateMixin {
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
              ? ChangeNotifierProvider(
                  create: (BuildContext context) =>
                      MenuLogicProvider()..customMenuAppManger.initMenuValue(),
                  child: Consumer<MenuLogicProvider>(
                    builder: (_, model, __) {
                      return GestureDetector(
                        onPanUpdate: (tapInfo) {
                          model.realTimeUpdatingValues(context, tapInfo);
                        },
                        onPanEnd: (de) {
                          model.leaveScreenWhenMenuMoving(context);
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
                                            begin: model.customMenuAppManger
                                                .tweenBeginScale,
                                            end: model.customMenuAppManger
                                                .tweenEndScale),
                                        duration:
                                            const Duration(milliseconds: 150),
                                        builder: (_, value, ___) {
                                          return Transform.scale(
                                              scale: (1 - value),
                                              child: RefreshIndicator(
                                                onRefresh: () async {
                                                  homeScreenCubit
                                                      .clearHomeScreenData();
                                                  homeScreenCubit.getData(
                                                      uId!, context);
                                                },
                                                child: homeScreenCubit
                                                        .homeMenuPages[
                                                    homeScreenCubit
                                                        .currentPage],
                                              ));
                                        }),
                                    HomeScreenMenuStructure(
                                      tBeginColor: model
                                          .customMenuAppManger.tweenBeginColor,
                                      tEndColor: model
                                          .customMenuAppManger.tweenEndColor,
                                      normalizedXPosition: model
                                          .customMenuAppManger
                                          .normalizedXPosition,
                                      xPosition:
                                          model.customMenuAppManger.xPosition,
                                      onTapBlackBackGround: () {
                                        setState(() {
                                          model.customMenuAppManger
                                              .closeMenu(context);
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              );
                            }),
                      );
                    },
                  ),
                )
              : WaitingScreen(
                  action: () {
                    homeScreenCubit.getData(uId!, context);
                  },
                );
        },
        listener: (context, state) {});
  }
}
