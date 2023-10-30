import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fun_adventure/cores/utils/wating_screen.dart';
import 'package:fun_adventure/features/home/presentation/view/widgets/home_screen_widgets/home_screen_widget.dart';
import 'package:fun_adventure/features/home/presentation/view_model/main_screen_cubit/main_screen_cubit.dart';

import '../../../../constants.dart';
import '../view_model/home_screen_cubit/home_screen_cubit.dart';
import '../view_model/home_screen_cubit/home_screen_states.dart';

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
    return BlocProvider(
      create: (context) =>
      HomeScreenCubit()
        ..blocOperations(uId!, context),
      child: BlocConsumer<HomeScreenCubit, HomeScreenStates>(
          builder: (context, state) {
            AppMainScreenCubit appMainScreenCubit =
            AppMainScreenCubit.get(context);

            if (appMainScreenCubit.recentNews.isNotEmpty &&
                appMainScreenCubit.hotTravels.isNotEmpty) {
              return const HomeScreenWidget();
            } else {
              return const WaitingScreen();
            }
          },
          listener: (context, state) {}),
    );
  }
}
