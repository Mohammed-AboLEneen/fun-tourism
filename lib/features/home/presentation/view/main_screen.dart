import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fun_adventure/features/home/presentation/view/widgets/main_screen_widget/main_screen_widget.dart';
import 'package:fun_adventure/features/home/presentation/view_model/main_screen_cubit/main_screen_cubit.dart';
import 'package:fun_adventure/features/home/presentation/view_model/notification_circle_red_provider/notification_circle_red_provider.dart';
import 'package:provider/provider.dart';

import '../../../../cores/utils/firebase_api.dart';
import '../../../../cores/utils/locator_manger.dart';

class AppMainScreen extends StatefulWidget {
  const AppMainScreen({super.key});

  @override
  State<AppMainScreen> createState() => _AppMainScreenState();
}

class _AppMainScreenState extends State<AppMainScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    LocatorManager.locateFirebaseMessagingObject();
    LocatorManager.locator<FirebaseApi>().initNotifications();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => NotificationProvider()..initNotificationsListener(),
      child: BlocProvider(
        create: (context) =>
            AppMainScreenCubit()..internetConnection.initConnectivity(),
        child: const AppMainScreenWidget(),
      ),
    );
  }
}
