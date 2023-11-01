import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fun_adventure/features/home/presentation/view/widgets/home_screen_widgets/home_screen_widget.dart';

import '../../../../constants.dart';
import '../view_model/home_screen_cubit/home_screen_cubit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int sliderBannerCurrentIndex = 0;

  @override
  void initState() {
    print('this is uId : $uId');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeScreenCubit()..blocOperations(uId!, context),
      child: const HomeScreenWidget(),
    );
  }
}
