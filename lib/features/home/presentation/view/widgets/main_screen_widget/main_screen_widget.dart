import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fun_adventure/cores/utils/screen_dimentions.dart';
import 'package:fun_adventure/features/home/presentation/view/widgets/home_screen_widgets/button_navegation_bar_item.dart';
import 'package:fun_adventure/features/home/presentation/view/widgets/home_screen_widgets/custom_menu.dart';
import 'package:fun_adventure/features/home/presentation/view_model/main_screen_cubit/main_screen_states.dart';

import '../../../../../../cores/utils/firebase_api.dart';
import '../../../view_model/main_screen_cubit/main_screen_cubit.dart';

class AppMainScreenWidget extends StatefulWidget {
  const AppMainScreenWidget({super.key});

  @override
  State<AppMainScreenWidget> createState() => _AppMainScreenState();
}

class _AppMainScreenState extends State<AppMainScreenWidget> {
  CustomMenuApp customMenuApp = CustomMenuApp();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    FirebaseApi().initNotifications();
    initInternetConnectionCubitObject();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppMainScreenCubit, AppMainScreenStates>(
      builder: (context, state) {
        AppMainScreenCubit appMainScreenCubit = AppMainScreenCubit.get(context);

        return Scaffold(
          body: Stack(
            children: [
              appMainScreenCubit.screens[appMainScreenCubit.currentIndex],
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
                                  icon: appMainScreenCubit
                                      .bottomNavigationBarIcons[index],
                                  index: index,
                                  currentIndex: appMainScreenCubit.currentIndex,
                                  onTap: () {
                                    appMainScreenCubit
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

  void initInternetConnectionCubitObject() {
    BlocProvider.of<AppMainScreenCubit>(context)
        .internetConnection
        .initCubitObject(BlocProvider.of<AppMainScreenCubit>(context));
  }
}
