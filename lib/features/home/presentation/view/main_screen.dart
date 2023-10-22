import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fun_adventure/features/home/presentation/view/widgets/main_screen_widget/main_screen_widget.dart';
import 'package:fun_adventure/features/home/presentation/view_model/home_cubit/app_main_screen_cubit.dart';

import '../../../../constants.dart';
import '../../../../cores/utils/sheard_preferance_helper.dart';

class AppMainScreen extends StatefulWidget {
  const AppMainScreen({super.key});

  @override
  State<AppMainScreen> createState() => _AppMainScreenState();
}

class _AppMainScreenState extends State<AppMainScreen> {
  late String userEmail;

  @override
  void initState() {
    super.initState();
    userEmail = SharedPreferenceHelper.getString(key: userEmailKey) ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppMainScreenCubit()..blocOperations(userEmail),
      child: const AppMainScreenWidget(),
    );
  }
}
