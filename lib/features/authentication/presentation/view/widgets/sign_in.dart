import 'package:flutter/material.dart';

import 'custom_textformfield.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  TextEditingController emailController = TextEditingController(text: '');
  TextEditingController passwordController = TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(

      slivers: [

        SliverFillRemaining(


          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                const Text(
                  'Welcome',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                CustomTextField(
                  controller: emailController,
                  hint: 'Email',
                  padding: const EdgeInsets.only(left: 10, top: 10),
                  icon: const Icon(Icons.alternate_email),
                ),
                const SizedBox(
                  height: 30,
                ),
                CustomTextField(
                  controller: emailController,
                  hint: 'Password',
                  padding: const EdgeInsets.only(left: 10, top: 10),
                  icon: const Icon(Icons.lock),
                ),
                const Spacer(),
                Row(

                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Don\'t have an account?',
                      style: TextStyle(fontSize: 15),
                    ),
                    TextButton(
                      onPressed: () {},
                      style: ButtonStyle(

                        overlayColor: MaterialStateProperty.resolveWith<Color>(
                              (Set<MaterialState> states) {
                            if (states.contains(MaterialState.pressed)) {
                              // Return the desired color when the button is pressed
                              return Colors.teal; // Replace with your desired color
                            }
                            // Return the default color when the button is not pressed
                            return Colors.transparent; // Replace with your default color
                          },
                        ),
                      ),
                      child: const Text(
                        'Register Now',
                        style: TextStyle(fontSize: 15, color: Colors.black),
                      ),
                    )
                  ],
                ),

              ],
            ),
          ),
        )
      ],
    );
  }
}
