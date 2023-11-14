import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../../cores/methods/toast.dart';
import '../../../../../cores/utils/custom_textformfield_underline.dart';
import '../../../../../cores/utils/routers.dart';
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
                          'Sign Up',
                          style: TextStyle(
                              fontSize: 30.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.white.withOpacity(1)),
                        ),
                        CustomTextFieldUnderline(
                          hint: 'Last Mame',
                          onChanged: (value) {
                            registerCubit.name = value;
                          },
                          padding: const EdgeInsets.only(left: 10, top: 10),
                          icon: Icon(Icons.person,
                              color: Colors.white.withOpacity(.9)),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomTextFieldUnderline(
                          hint: 'Phone',
                          onChanged: (value) {
                            registerCubit.phone = value;
                          },
                          padding: const EdgeInsets.only(left: 10, top: 10),
                          icon: Icon(Icons.phone_android,
                              color: Colors.white.withOpacity(.9)),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomTextFieldUnderline(
                          hint: 'Email',
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
                          hint: 'Password',
                          onChanged: (value) {
                            registerCubit.accountPassword = value;
                          },
                          padding: const EdgeInsets.only(left: 10, top: 10),
                          icon: Icon(Icons.alternate_email,
                              color: Colors.white.withOpacity(.9)),
                        ),
                        const Spacer(),
                      ],
                    ),
                  ),
                )
              ],
            ));
      },
      listener: (context, state) {
        if (state is RegisterSuccessState) {
          showToast(msg: 'verify your email', isFailure: false);
          context.go(RoutersClass.fromAuthScreenToEmailVerificationScreen);
        } else if (state is RegisterFailureState) {
          showToast(msg: state.message, isFailure: true);
        }
      },
    );
  }
}
