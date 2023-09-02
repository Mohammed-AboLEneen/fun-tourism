import 'package:flutter/material.dart';

import 'custom_textformfield.dart';

class RegisterBody extends StatefulWidget {
  RegisterBody({super.key});

  final TextEditingController phoneController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  State<RegisterBody> createState() => _RegisterBodyState();
}

class _RegisterBodyState extends State<RegisterBody> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(20.0),
        child: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Column(
                children: [
                  Text(
                    'Sign Up',
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.white.withOpacity(1)),
                  ),
                  CustomTextField(
                    controller: widget.firstNameController,
                    hint: 'First Name',
                    padding: const EdgeInsets.only(left: 10, top: 10),
                    icon: Icon(Icons.alternate_email,
                        color: Colors.white.withOpacity(.9)),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  CustomTextField(
                    controller: widget.lastNameController,
                    hint: 'Last Mame',
                    padding: const EdgeInsets.only(left: 10, top: 10),
                    icon: Icon(Icons.lock, color: Colors.white.withOpacity(.9)),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  CustomTextField(
                    controller: widget.phoneController,
                    hint: 'Phone',
                    padding: const EdgeInsets.only(left: 10, top: 10),
                    icon: Icon(Icons.alternate_email,
                        color: Colors.white.withOpacity(.9)),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  CustomTextField(
                    controller: widget.emailController,
                    hint: 'Email',
                    padding: const EdgeInsets.only(left: 10, top: 10),
                    icon: Icon(Icons.lock, color: Colors.white.withOpacity(.9)),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  CustomTextField(
                    controller: widget.passwordController,
                    hint: 'Password',
                    padding: const EdgeInsets.only(left: 10, top: 10),
                    icon: Icon(Icons.alternate_email,
                        color: Colors.white.withOpacity(.9)),
                  ),
                  const Spacer(),
                ],
              ),
            )
          ],
        ));
  }
}
