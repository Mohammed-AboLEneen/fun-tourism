import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fun_adventure/cores/models/user_data_info/user_info_data.dart';
import 'package:fun_adventure/features/authentication/presentation/view_model/register_cubit/register_cubit.dart';

import '../../../../../cores/methods/navigate_to.dart';
import '../../../../../cores/methods/toast.dart';
import '../../../../../cores/utils/firestore_service.dart';
import '../../../../home/presentation/view/main_screen.dart';

Future<void> addNewUserInFireStore(
    {required BuildContext context, required UserInfoData userInfoData}) async {
  try {
    await FireStoreServices.addUser(
        email: userInfoData.email,
        phoneNumber: userInfoData.phoneNumber ??
            BlocProvider.of<RegisterCubit>(context).phone,
        displayName: userInfoData.displayName ??
            BlocProvider.of<RegisterCubit>(context).name,
        photoURL: userInfoData.photoURL);

    if (!context.mounted) return;

    navigateToAndRemove(page: const AppMainScreen(), context: context);
  } catch (e) {
    showToast(
        msg: 'There is an error, sign in again.',
        bgColor: Colors.red.withOpacity(.7),
        txColor: Colors.white.withOpacity(.7));
  }
}
