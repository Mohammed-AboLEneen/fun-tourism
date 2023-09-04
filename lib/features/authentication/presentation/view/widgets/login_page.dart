import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fun_adventure/cores/methods/navigate_pageview.dart';

import 'custom_textformfield.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final PageController pageController;

  LoginPage({
    super.key,
    required this.pageController,
  });

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
                    'Sign In',
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.white.withOpacity(1)),
                  ),
                  CustomTextField(
                    controller: emailController,
                    hint: 'Email',
                    padding: const EdgeInsets.only(left: 10, top: 10),
                    icon: Icon(Icons.alternate_email,
                        color: Colors.white.withOpacity(.9)),
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
                        style: TextStyle(
                            fontSize: 15.sp,
                            color: Colors.white.withOpacity(.9)),
                      ),
                      SizedBox(
                        height: 35,
                        child: TextButton(
                          onPressed: () {
                            navigatePageView(pageController: pageController);
                          },
                          style: ButtonStyle(
                            padding:
                                MaterialStateProperty.all<EdgeInsetsGeometry>(
                                    const EdgeInsets.symmetric(horizontal: 5)),
                            overlayColor:
                                MaterialStateProperty.resolveWith<Color>(
                              (Set<MaterialState> states) {
                                if (states.contains(MaterialState.pressed)) {
                                  // Return the desired color when the button is pressed
                                  return Colors.white.withOpacity(
                                      .5); // Replace with your desired color
                                }
                                // Return the default color when the button is not pressed
                                return Colors
                                    .transparent; // Replace with your default color
                              },
                            ),
                          ),
                          child: Text(
                            'Register Now',
                            style: TextStyle(
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w700,
                                color: Colors.white.withOpacity(.9)),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
