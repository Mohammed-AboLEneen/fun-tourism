import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fun_adventure/cores/models/user_data_info/user_info_data.dart';
import 'package:intl/intl.dart';

import '../../../../../constants.dart';
import '../../../../../cores/methods/toast.dart';
import '../../../../../cores/utils/routers.dart';

Future<void> addNewUserInFireStore(
    {required BuildContext context, required UserInfoData userInfoData}) async {
  try {
    AggregateQuerySnapshot data =
        await FirebaseFirestore.instance.collection('users').count().get();
    int numberOfUsers = data.count;
    final now = DateTime.now();
    final formatter = DateFormat('yyyy-MM-dd');
    final formattedDate = formatter.format(now);

    if (!context.mounted) return;

    FirebaseFirestore.instance.collection('users').doc(uId).set({
      'email': userInfoData.email,
      // John Doe
      'phoneNumber': userInfoData.phoneNumber,
      // John Doe
      'displayName': userInfoData.displayName,
      // Stokes and Sons
      'photoURL': '',
      'userTopic': '/topics/user_$uId',
      'countNumber': '${numberOfUsers + 1}',
      'created in': formattedDate
    });

    if (!context.mounted) return;
    Navigator.pushNamedAndRemoveUntil(
        context, RoutersClass.appMainScreen, (route) => false);
  } catch (e) {
    showToast(
        msg: 'There is an error, sign in again.',
        toastMessageType: ToastMessageType.failureMessage);
  }
}
