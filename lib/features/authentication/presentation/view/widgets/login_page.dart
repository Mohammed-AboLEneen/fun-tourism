import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fun_adventure/cores/methods/google_sign_out.dart';
import 'package:fun_adventure/cores/methods/navigate_pageview.dart';
import 'package:fun_adventure/cores/methods/toast.dart';
import 'package:fun_adventure/cores/models/user_data_info/user_info_data.dart';
import 'package:fun_adventure/cores/utils/images.dart';
import 'package:fun_adventure/cores/utils/routers.dart';
import 'package:fun_adventure/cores/utils/screen_dimentions.dart';
import 'package:fun_adventure/features/home/presentation/view/main_screen.dart';

import '../../../../../constants.dart';
import '../../../../../cores/utils/custom_textformfield_underline.dart';
import '../../../../../cores/utils/sheard_preferance_helper.dart';
import '../../view_model/login_cubit/login_cubit.dart';
import '../../view_model/login_cubit/login_states.dart';
import '../methods/add_user_data.dart';

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
                              fontSize: 30.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.white.withOpacity(1)),
                        ),
                        SizedBox(
                          height: context.height * .09,
                          child: CustomTextFieldUnderline(
                            hint: 'Email',
                            onChanged: (value) {
                              loginCubit.putEmailAddress = value;
                            },
                            padding: const EdgeInsets.only(left: 10, top: 10),
                            icon: Icon(Icons.alternate_email,
                                color: Colors.white.withOpacity(.9)),
                          ),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        SizedBox(
                          height: context.height * .09,
                          child: CustomTextFieldUnderline(
                            hint: 'Password',
                            onChanged: (value) {
                              print(value);
                              loginCubit.putPassword = value;
                            },
                            padding: const EdgeInsets.only(left: 10, top: 10),
                            icon: Icon(Icons.lock,
                                color: Colors.white.withOpacity(.9)),
                          ),
                        ),
                        const Spacer(),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * .45,
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
                                    ImagesClass.googleLogoPngImage,
                                    fit: BoxFit.cover,
                                    width:
                                        MediaQuery.of(context).size.width * .12,
                                  ),
                                  const Spacer(),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: Text(
                                      'Sign in with google',
                                      style: TextStyle(fontSize: 15.sp),
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
                ),
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: MediaQuery.of(context).viewInsets.bottom,
                  ),
                )
              ],
            ));
      },
      listener: (BuildContext context, state) async {
        if (state is LoginSuccessState) {
          // make sure not display login screen anymore while user not sign out.
          SharedPreferenceHelper.setBool(key: loginKey, value: true);

          await SharedPreferenceHelper.setString(
              key: uIdKey, value: state.user.uid ?? '');
          uId = SharedPreferenceHelper.getString(key: uIdKey);

          if (!context.mounted) return;

          // if isGoogleAuth is false, it mean that user choose Email and Password method, if else he choose google sign in
          if (state.isGoogleAuth) {
            checkIsThisNewUser(
                context: context, user: state.user, newUser: state.isNewUser);
          } else {
            // if user just verified his email, so he don't have any data in fireStore yet.
            // we will add it by checking if he has data in FireStore or not.
            if (state.emailVerified) {
              bool isExist = await checkIfDocumentExists(uId!);

              if (!context.mounted) return;

              if (isExist) {
                Navigator.pushNamedAndRemoveUntil(
                    context, RoutersClass.appMainScreen, (route) => false);
              } else {
                await addNewUserInFireStore(
                    userInfoData: state.user, context: context);
              }
            } else {
              Navigator.pushNamed(
                context,
                RoutersClass.emailVerificationScreen,
              );
            }
          }
        } else if (state is LoginFailureState) {
          showToast(
              msg: state.message,
              toastMessageType: ToastMessageType.failureMessage);
        }
      },
    );
  }
}

void checkIsThisNewUser({
  required BuildContext context,
  required UserInfoData user,
  required bool? newUser,
}) async {
  // if user is new, it will create a documentation in fireStore for him.
  if (newUser != null) {
    if (newUser) {
      await addNewUserInFireStore(userInfoData: user, context: context);
    }

    await SharedPreferenceHelper.setString(key: uIdKey, value: user.uid ?? '');

    if (!context.mounted) return;
    Navigator.pushAndRemoveUntil(context,
        PageRouteBuilder(pageBuilder: (context, a1, a2) {
      return const AppMainScreen();
    }), (route) => false);
  } else {
    showToast(
        msg: 'Something is wrong, try again.',
        toastMessageType: ToastMessageType.failureMessage);
  }
}

Future<bool> checkIfDocumentExists(String uId) async {
  final DocumentReference documentRef =
      FirebaseFirestore.instance.collection('users').doc(uId);

  final DocumentSnapshot documentSnapshot = await documentRef.get();

  return documentSnapshot.exists;
}
