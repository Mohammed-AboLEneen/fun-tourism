import 'package:flutter/material.dart';
import 'package:fun_adventure/features/authentication/presentation/view/widgets/login_body.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(

      body: LoginBody(),
    );
  }
}
