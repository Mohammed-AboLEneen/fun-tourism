import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fun_adventure/constants.dart';
import 'package:fun_adventure/cores/utils/screen_dimentions.dart';
import 'package:fun_adventure/cores/utils/sheard_preferance_helper.dart';
import 'package:fun_adventure/features/home/presentation/view/widgets/home_screen_widgets/button_navegation_bar_item.dart';
import 'package:fun_adventure/features/home/presentation/view/widgets/home_screen_widgets/main_screen_menu.dart';
import 'package:fun_adventure/features/home/presentation/view_model/home_cubit/app_main_screen_cubit.dart';

import '../../../../cores/utils/images.dart';
import '../view_model/home_cubit/app_main_screen_states.dart';

class AppMainScreen extends StatefulWidget {
  const AppMainScreen({super.key});

  @override
  State<AppMainScreen> createState() => _AppMainScreenState();
}

class _AppMainScreenState extends State<AppMainScreen> {
  @override
  void initState() {
    userEmail = SharedPreferenceHelper.getString(key: userEmailKey);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppMainScreenCubit()..blocOperations(userEmail!),
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
              drawer: const MainScreenMenu(),
              backgroundColor: Colors.transparent,
              body: appMainScreenCubit.recentNews.isNotEmpty &&
                      appMainScreenCubit.hotTravels.isNotEmpty
                  ? Stack(
                      children: [
                        appMainScreenCubit
                            .screens[appMainScreenCubit.currentIndex],
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
                                  height: context.height * .07,
                                  width: context.width * .6,
                                  decoration: BoxDecoration(
                                      color: const Color(0xff313745)
                                          .withOpacity(.8),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(20))),
                                  child: ListView.builder(
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) =>
                                          CustomBottomNavigationBarItem(
                                            icon: appMainScreenCubit
                                                    .bottomNavigationBarIcons[
                                                index],
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
                    )
                  : const Center(
                      child: CircularProgressIndicator(
                        color: Colors.indigo,
                      ),
                    ),
            ),
          );
        },
        listener: (context, state) {},
      ),
    );
  }
}
