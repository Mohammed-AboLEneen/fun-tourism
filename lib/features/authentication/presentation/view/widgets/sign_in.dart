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
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          Text(
            'Welcome',
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold,  color: Colors.white.withOpacity(1)),
          ),
          CustomTextField(
            controller: emailController,
            hint: 'Email',
            padding: const EdgeInsets.only(left: 10, top: 10),
            icon: Icon(Icons.alternate_email, color: Colors.white.withOpacity(.9)),
          ),
          const SizedBox(
            height: 30,
          ),
          CustomTextField(
            controller: passwordController,
            hint: 'Password',
            padding: const EdgeInsets.only(left: 10, top: 10),
            icon: Icon(Icons.lock, color: Colors.white.withOpacity(.9)),
          ),
          const Spacer(),
          Row(

            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Don\'t have an account?',
                style: TextStyle(fontSize: 15,  color: Colors.white.withOpacity(.9)),
              ),
              TextButton(
                onPressed: () {},
                style: ButtonStyle(

                  overlayColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                      if (states.contains(MaterialState.pressed)) {
                        // Return the desired color when the button is pressed
                        return Colors.white.withOpacity(.5); // Replace with your desired color
                      }
                      // Return the default color when the button is not pressed
                      return Colors.transparent; // Replace with your default color
                    },
                  ),
                ),
                child: Text(
                  'Register Now',
                  style: TextStyle(fontSize: 15,  color: Colors.white.withOpacity(.9)),
                ),
              )
            ],
          ),

        ],
      ),
    );
  }
}
