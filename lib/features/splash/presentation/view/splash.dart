import 'package:flutter/material.dart';
import 'package:fun_adventure/features/splash/presentation/view/widgets/splash_body.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(

      body: SplashViewBody(),
    );
  }
}
