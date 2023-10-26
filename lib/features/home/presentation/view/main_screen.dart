import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fun_adventure/features/home/presentation/view/widgets/main_screen_widget/main_screen_widget.dart';

import '../../../../constants.dart';
import '../../../../cores/utils/sheard_preferance_helper.dart';
import '../view_model/main_screen_cubit/app_main_screen_cubit.dart';

class AppMainScreen extends StatefulWidget {
  const AppMainScreen({super.key});

  @override
  State<AppMainScreen> createState() => _AppMainScreenState();
}

class _AppMainScreenState extends State<AppMainScreen> {
  late String uId;

  @override
  void initState() {
    super.initState();
    uId = SharedPreferenceHelper.getString(key: uIdKey) ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppMainScreenCubit()..blocOperations(uId),
      child: const AppMainScreenWidget(),
    );
  }
}
