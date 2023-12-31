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
import '../../wating_screen.dart';

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
                    builder: (_, homeMenu, __) {
                      return GestureDetector(
                        onPanUpdate: (tapInfo) {
                          homeMenu.realTimeUpdatingValues(context, tapInfo);
                        },
                        onPanEnd: (de) {
                          homeMenu.leaveScreenWhenMenuMoving(context);
                        },
                        child: Stack(
                          children: [
                            TweenAnimationBuilder(
                                tween: Tween<double>(
                                    begin: homeMenu
                                        .customMenuAppManger.tweenBeginScale,
                                    end: homeMenu
                                        .customMenuAppManger.tweenEndScale),
                                duration: const Duration(milliseconds: 150),
                                builder: (_, value, ___) {
                                  return Transform.scale(
                                      scale: (1 - value),
                                      child: RefreshIndicator(
                                        onRefresh: () async {
                                          homeScreenCubit.clearHomeScreenData();
                                          homeScreenCubit.getData(
                                              uId!, context);
                                        },
                                        color: Colors.indigo,
                                        child: homeScreenCubit.homeMenuPages[
                                            homeScreenCubit.currentPage],
                                      ));
                                }),
                            HomeScreenMenuStructure(
                              tBeginColor:
                                  homeMenu.customMenuAppManger.tweenBeginColor,
                              tEndColor:
                                  homeMenu.customMenuAppManger.tweenEndColor,
                              normalizedXPosition: homeMenu
                                  .customMenuAppManger.normalizedXPosition,
                              xPosition: homeMenu.customMenuAppManger.xPosition,
                              onTapBlackBackGround: () {
                                setState(() {
                                  homeMenu.customMenuAppManger
                                      .closeMenu(context);
                                });
                              },
                            ),
                          ],
                        ),
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
