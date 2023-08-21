import 'package:flutter/material.dart';
import 'package:fun_adventure/features/authentication/presentation/view/widgets/login_body.dart';
import 'package:fun_adventure/features/authentication/presentation/view/widgets/register_body.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: RegisterBody(),
    );
  }
}
