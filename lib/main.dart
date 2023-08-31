import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fun_adventure/features/splash/presentation/view/splash.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
            textTheme: GoogleFonts.abelTextTheme(ThemeData.light().textTheme),
            colorScheme: ColorScheme.fromSeed(
                primary: Colors.white, seedColor: Colors.blue),
            useMaterial3: true,
            scaffoldBackgroundColor: Colors.transparent),
        home: const SplashPage(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
