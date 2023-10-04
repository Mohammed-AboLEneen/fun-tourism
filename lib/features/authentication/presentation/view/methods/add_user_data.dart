import 'package:flutter/material.dart';
import 'package:fun_adventure/cores/models/user_data_info/user_info_data.dart';

import '../../../../../cores/methods/navigate_to.dart';
import '../../../../../cores/methods/toast.dart';
import '../../../../../cores/utils/firestore_service.dart';
import '../../../../home/presentation/view/widgets/home_screen.dart';

Future<void> addNewUserInFireStore(
    {required BuildContext context, required UserInfoData userInfoData}) async {
  try {
    await FireStoreServices.addUser(
        email: userInfoData.email,
        phoneNumber: userInfoData.phoneNumber,
        displayName: userInfoData.displayName,
        photoURL: userInfoData.photoURL);

    if (context.mounted) {
      navigateTo(page: const HomeScreen(), context: context);
    }
  } catch (e) {
    showToast(
        msg: 'There is an error, sign in again.',
        bgColor: Colors.red.withOpacity(.7),
        txColor: Colors.white.withOpacity(.7));
  }
}
