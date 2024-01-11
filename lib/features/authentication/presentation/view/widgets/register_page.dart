import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fun_adventure/cores/utils/color_degree.dart';
import 'package:fun_adventure/cores/utils/screen_dimentions.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../cores/methods/toast.dart';
import '../../../../../cores/utils/routers.dart';
import '../../../../../cores/widgets/custom_textformfield_underline.dart';
import '../../view_model/register_cubit/register_cubit.dart';
import '../../view_model/register_cubit/register_states.dart';

class RegisterPage extends StatefulWidget {
  final GlobalKey fromKey;
  final AutovalidateMode autovalidateMode;

  const RegisterPage(
      {super.key, required this.fromKey, required this.autovalidateMode});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool isVisiable = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit, RegisterStates>(
      builder: (context, state) {
        RegisterCubit registerCubit = RegisterCubit.get(context);

        return Padding(
            padding: const EdgeInsets.all(20.0),
            child: CustomScrollView(
              slivers: [
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Form(
                    key: widget.fromKey,
                    autovalidateMode: widget.autovalidateMode,
                    child: Column(
                      children: [
                        if (state is RegisterLoadingState)
                          const LinearProgressIndicator(),
                        Text(
                          'Create Account',
                          style: TextStyle(
                              fontSize: 30.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.white.withOpacity(1)),
                        ),
                        SizedBox(
                          height: context.height * .035,
                        ),
                        CustomTextFieldUnderline(
                          hint: 'Your Email Address',
                          keyboardType: TextInputType.emailAddress,
                          onChanged: (value) {
                            registerCubit.emailAddress = value;
                          },
                          padding: const EdgeInsets.only(left: 10, top: 10),
                          icon: Icon(Icons.email,
                              color: Colors.white.withOpacity(.9)),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomTextFieldUnderline(
                          hint: 'New Password',
                          obscureText: isVisiable,
                          onChanged: (value) {
                            registerCubit.accountPassword = value;
                          },
                          padding: const EdgeInsets.only(left: 10, top: 10),
                          icon: GestureDetector(
                            onTap: () {
                              isVisiable = !isVisiable;
                              setState(() {});
                            },
                            child: Icon(
                                isVisiable
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: Colors.white.withOpacity(.9)),
                          ),
                        ),
                        Container(
                          height: context.height * .2,
                          margin: const EdgeInsets.all(20),
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                              color: Colors.blue.withOpacity(.3),
                              borderRadius: BorderRadius.circular(20)),
                          child: Text(
                            'Don\'t Forget Verify Your Email After Done This Process',
                            style: GoogleFonts.aBeeZee(
                                fontSize: 20.sp,
                                color: Colors.white.withLightness(.85)),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 700),
                    height: 100,
                  ),
                )
              ],
            ));
      },
      listener: (context, state) {
        if (state is RegisterSuccessState) {
          showToast(
              msg: 'verify your email',
              textColor: Colors.black,
              toastMessageType: ToastMessageType.waitingMessage);
          Navigator.pushNamed(
            context,
            RoutersClass.emailVerificationScreen,
          );
        } else if (state is RegisterFailureState) {
          showToast(
              msg: state.message,
              toastMessageType: ToastMessageType.failureMessage);
        }
      },
    );
  }
}
