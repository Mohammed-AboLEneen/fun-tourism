import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fun_adventure/cores/models/user_data_info/user_info_data.dart';
import 'package:fun_adventure/features/authentication/presentation/view_model/register_cubit/register_cubit.dart';

import '../../../../../cores/methods/toast.dart';
import '../../../../../cores/utils/firestore_service.dart';
import '../../../../../cores/utils/routers.dart';

Future<void> addNewUserInFireStore(
    {required BuildContext context, required UserInfoData userInfoData}) async {
  try {
    AggregateQuerySnapshot data =
        await FirebaseFirestore.instance.collection('users').count().get();
    int numberOfUsers = data.count;

    if (!context.mounted) return;
    await FireStoreServices.addUser(
        email: userInfoData.email,
        uId: userInfoData.uid,
        phoneNumber: userInfoData.phoneNumber ??
            BlocProvider.of<RegisterCubit>(context).phone,
        displayName: userInfoData.displayName ??
            BlocProvider.of<RegisterCubit>(context).name,
        photoURL: userInfoData.photoURL,
        userNumber: numberOfUsers + 1);

    if (!context.mounted) return;

    Navigator.pushNamedAndRemoveUntil(
        context, RoutersClass.appMainScreen, (route) => false);
  } catch (e) {
    showToast(
        msg: 'There is an error, sign in again.',
        toastMessageType: ToastMessageType.failureMessage);
  }
}
