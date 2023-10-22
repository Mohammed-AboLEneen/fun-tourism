import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fun_adventure/cores/utils/wating_screen.dart';
import 'package:fun_adventure/features/home/presentation/view/widgets/home_screen_widgets/home_screen_widget.dart';
import 'package:fun_adventure/features/home/presentation/view_model/home_cubit/app_main_screen_cubit.dart';
import 'package:fun_adventure/features/home/presentation/view_model/home_cubit/app_main_screen_states.dart';

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

          if (appMainScreenCubit.recentNews.isNotEmpty &&
              appMainScreenCubit.hotTravels.isNotEmpty) {
            return HomeScreenWidget(appMainScreenCubit: appMainScreenCubit);
          } else {
            return const WaitingScreen();
          }
        },
        listener: (context, state) {});
  }
}
