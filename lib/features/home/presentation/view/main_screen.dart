import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fun_adventure/constants.dart';
import 'package:fun_adventure/features/home/presentation/view/widgets/button_navegation_bar_item.dart';
import 'package:fun_adventure/features/home/presentation/view/widgets/home_page_menu.dart';
import 'package:fun_adventure/features/home/presentation/view_model/home_cubit/app_main_screen_cubit.dart';

import '../../../../cores/utils/images.dart';
import '../view_model/home_cubit/app_main_screen_states.dart';

class AppMainScreen extends StatelessWidget {
  const AppMainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    return BlocProvider(
      create: (context) => AppMainScreenCubit()..getUserData(userEmail ?? ''),
      child: BlocConsumer<AppMainScreenCubit, AppMainScreenStates>(
        builder: (context, state) {
          AppMainScreenCubit appMainScreenCubit =
              AppMainScreenCubit.get(context);

          return Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(ImagesClass.homeBgPngImage),
                  fit: BoxFit.fill),
            ),
            child: Scaffold(
              drawer: const HomeMenu(),
              backgroundColor: Colors.transparent,
              body: Stack(
                children: [
                  appMainScreenCubit.screens[appMainScreenCubit.currentIndex],
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20)),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaY: 5, sigmaX: 5),
                          child: Container(
                            height: h * .07,
                            width: w * .6,
                            decoration: BoxDecoration(
                                color: const Color(0xff313745).withOpacity(.8),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(20))),
                            child: ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) =>
                                    CustomBottomNavigationBarItem(
                                      icon: appMainScreenCubit
                                          .bottomNavigationBarIcons[index],
                                      index: index,
                                      currentIndex:
                                          appMainScreenCubit.currentIndex,
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
              ),
            ),
          );
        },
        listener: (context, state) {},
      ),
    );
  }
}
