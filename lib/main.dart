import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fun_adventure/cores/models/hot_travels_model/hot_travels_model.dart';
import 'package:fun_adventure/cores/models/recent_news_model/recent_news_model.dart';
import 'package:fun_adventure/cores/models/user_app_data/user_app_data.dart';
import 'package:fun_adventure/cores/models/user_data_info/user_info_data.dart';
import 'package:fun_adventure/cores/utils/routers.dart';
import 'package:fun_adventure/cores/utils/sheard_preferance_helper.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'cores/utils/bloc_observer.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = MyBlocObserver();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await SharedPreferenceHelper.initSharedPreference();
  await Hive.initFlutter();

  Hive.registerAdapter(
    UserAppDataAdapter(),
  );
  Hive.registerAdapter(
    UserInfoDataAdapter(),
  );
  Hive.registerAdapter(
    HotTravelModelAdapter(),
  );
  Hive.registerAdapter(RecentNewsModelAdapter());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp.router(
          routerConfig: RoutersClass.router,
          title: 'Flutter Demo',
          theme: ThemeData(
            textTheme: GoogleFonts.abelTextTheme(ThemeData.light().textTheme),
            textSelectionTheme: TextSelectionThemeData(
              selectionColor: Colors.grey.withOpacity(.8),
              cursorColor: Colors.blue,
              selectionHandleColor: Colors.blue,
            ),
            appBarTheme: Theme.of(context)
                .appBarTheme
                .copyWith(systemOverlayStyle: SystemUiOverlayStyle.dark),
            colorScheme: ColorScheme.fromSeed(
                primary: Colors.white, seedColor: Colors.blue),
            useMaterial3: true,
          ),
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}
