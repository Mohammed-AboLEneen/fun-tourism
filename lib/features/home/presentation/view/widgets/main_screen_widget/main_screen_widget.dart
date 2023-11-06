import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fun_adventure/constants.dart';
import 'package:fun_adventure/cores/utils/color_degree.dart';
import 'package:fun_adventure/cores/utils/locator_manger.dart';
import 'package:fun_adventure/cores/utils/screen_dimentions.dart';
import 'package:fun_adventure/cores/utils/sheard_preferance_helper.dart';
import 'package:fun_adventure/features/home/presentation/view/widgets/home_screen_widgets/button_navegation_bar_item.dart';
import 'package:fun_adventure/features/home/presentation/view/widgets/home_screen_widgets/home_menu/custom_menu_manger.dart';
import 'package:fun_adventure/features/home/presentation/view_model/main_screen_cubit/main_screen_states.dart';

import '../../../view_model/main_screen_cubit/main_screen_cubit.dart';

class AppMainScreenWidget extends StatefulWidget {
  const AppMainScreenWidget({super.key});

  @override
  State<AppMainScreenWidget> createState() => _AppMainScreenState();
}

class _AppMainScreenState extends State<AppMainScreenWidget> {
  MangeCustomMenuApp customMenuApp = MangeCustomMenuApp();

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();

    uId = SharedPreferenceHelper.getString(key: uIdKey);
    LocatorManager.locateAppMainScreenCubit();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppMainScreenCubit, AppMainScreenStates>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.white.withLightness(.94),
          body: Stack(
            children: [
              LocatorManager.locator<AppMainScreenCubit>().screens[
                  LocatorManager.locator<AppMainScreenCubit>().currentIndex],
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaY: 5, sigmaX: 5),
                      child: Container(
                        height: context.height * .07,
                        width: context.width * .6,
                        decoration: BoxDecoration(
                            color: const Color(0xff313745).withOpacity(.8),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20))),
                        child: ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) =>
                                CustomBottomNavigationBarItem(
                                  icon: LocatorManager.locator<
                                          AppMainScreenCubit>()
                                      .bottomNavigationBarIcons[index],
                                  index: index,
                                  currentIndex: LocatorManager.locator<
                                          AppMainScreenCubit>()
                                      .currentIndex,
                                  onTap: () {
                                    LocatorManager.locator<AppMainScreenCubit>()
                                        .changeNavigationBar(index);
                                  },
                                ),
                            itemCount: 4),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
      listener: (context, state) {},
    );
  }
}
