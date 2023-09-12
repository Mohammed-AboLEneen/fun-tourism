import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fun_adventure/cores/methods/navigate_pageview.dart';
import 'package:fun_adventure/cores/methods/navigate_to.dart';
import 'package:fun_adventure/cores/methods/toast.dart';
import 'package:fun_adventure/cores/utils/images.dart';
import 'package:fun_adventure/features/home/presentation/view/home_page.dart';

import '../../../../../cores/methods/google_sign_out.dart';
import '../../view_model/login_cubit/login_cubit.dart';
import '../../view_model/login_cubit/login_states.dart';
import 'custom_textformfield.dart';

class LoginPage extends StatefulWidget {
  final PageController pageController;
  final GlobalKey<FormState> formKey;
  final AutovalidateMode autovalidateMode;

  const LoginPage({
    super.key,
    required this.pageController,
    required this.formKey,
    required this.autovalidateMode,
  });

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginStates>(
      builder: (BuildContext context, state) {
        LoginCubit loginCubit = LoginCubit.get(context);

        return Padding(
            padding: const EdgeInsets.all(20.0),
            child: CustomScrollView(
              slivers: [
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Form(
                    key: widget.formKey,
                    autovalidateMode: widget.autovalidateMode,
                    child: Column(
                      children: [
                        if (state is LoginLoadingState)
                          const LinearProgressIndicator(),
                        Text(
                          'Log In',
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.white.withOpacity(1)),
                        ),
                        CustomTextField(
                          hint: 'Email',
                          onChanged: (value) {
                            loginCubit.putEmailAddress(value);
                          },
                          padding: const EdgeInsets.only(left: 10, top: 10),
                          icon: Icon(Icons.alternate_email,
                              color: Colors.white.withOpacity(.9)),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        CustomTextField(
                          hint: 'Password',
                          onChanged: (value) {
                            print(value);
                            loginCubit.putPassword(value);
                          },
                          padding: const EdgeInsets.only(left: 10, top: 10),
                          icon: Icon(Icons.lock,
                              color: Colors.white.withOpacity(.9)),
                        ),
                        const Spacer(),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * .5,
                          height: MediaQuery.of(context).size.height * .06,
                          child: TextButton(
                              onPressed: () async {
                                await googleSignOut();
                                loginCubit.createOrSignInWithGoogle();
                              },
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.blue.withOpacity(.4)),
                                  // Set the desired background color here
                                  padding:
                                      MaterialStateProperty.all<EdgeInsets>(
                                          EdgeInsets.zero),
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder?>(
                                      const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    bottomRight: Radius.circular(10),
                                  )))),
                              child: Row(
                                children: [
                                  Image.asset(
                                    ImagesClass.googleLogoImage,
                                    fit: BoxFit.cover,
                                  ),
                                  const Spacer(),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: Text(
                                      'Sign in with google',
                                      style: TextStyle(fontSize: 17.sp),
                                    ),
                                  ),
                                ],
                              )),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
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
                                  navigatePageView(
                                      pageController: widget.pageController);
                                },
                                style: ButtonStyle(
                                  padding: MaterialStateProperty.all<
                                          EdgeInsetsGeometry>(
                                      const EdgeInsets.symmetric(
                                          horizontal: 5)),
                                  overlayColor:
                                      MaterialStateProperty.resolveWith<Color>(
                                    (Set<MaterialState> states) {
                                      if (states
                                          .contains(MaterialState.pressed)) {
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
                  ),
                )
              ],
            ));
      },
      listener: (BuildContext context, state) {
        if (state is LoginSuccessState) {
          showToast(
              msg: 'Welcome',
              bgColor: Colors.green.withOpacity(.7),
              txColor: Colors.white.withOpacity(.7));

          navigateTo(page: const HomePage(), context: context);
        } else if (state is LoginFailureState) {
          showToast(
              msg: state.message,
              bgColor: Colors.red.withOpacity(.7),
              txColor: Colors.white.withOpacity(.7));
        }
      },
    );
  }
}
