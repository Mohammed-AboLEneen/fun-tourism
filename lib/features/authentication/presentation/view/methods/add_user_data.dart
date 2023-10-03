import 'package:flutter/material.dart';
import 'package:fun_adventure/cores/utils/user_info_data.dart';

import '../../../../../cores/methods/navigate_to.dart';
import '../../../../../cores/methods/toast.dart';
import '../../../../../cores/utils/firestore_service.dart';
import '../../../../home/presentation/view/home_page.dart';

Future<void> addNewUserInFireStore(
    {required BuildContext context, required UserInfoData userInfoData}) async {
  try {
    await FireStoreServices.addUser(
        email: userInfoData.email,
        phoneNumber: userInfoData.phoneNumber,
        displayName: userInfoData.displayName,
        photoURL: userInfoData.photoURL);

    if (context.mounted) {
      navigateTo(page: const HomePage(), context: context);
    }
  } catch (e) {
    showToast(
        msg: 'There is an error, sign in again.',
        bgColor: Colors.red.withOpacity(.7),
        txColor: Colors.white.withOpacity(.7));
  }
}
