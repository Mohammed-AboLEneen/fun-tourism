import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fun_adventure/features/home/presentation/view_model/profile_cubit/profile_cubit.dart';

import '../../../../custom_textbutton.dart';

class ProfileFollowButton extends StatelessWidget {
  final String id;

  const ProfileFollowButton({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(builder: (context, state) {
      ProfileScreenCubit profileScreenCubit = ProfileScreenCubit.get(context);
      return Padding(
          padding: EdgeInsets.only(top: 20.h),
          child: Expanded(
              child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0.w),
                  child: CustomTextButton(
                    text: profileScreenCubit.followButtonText,
                    buttonColor: profileScreenCubit.followButtonColor,
                    topRight: 20,
                    topLeft: 20,
                    textSize: 17,
                    onPressed: () {
                      profileScreenCubit.chooseTheFollowButtonAction(id);
                    },
                  ))));
    });
  }
}
