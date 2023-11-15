import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fun_adventure/cores/utils/color_degree.dart';

class ToastMessageType {
  static String failureMessage = "Failure";
  static String successMessage = "Success";
  static String waitingMessage = "Waiting";
}

void showToast(
    {required String msg, required String toastMessageType, Color? textColor}) {
  late Color bgColor;
  if (toastMessageType == ToastMessageType.successMessage) {
    bgColor = Colors.green;
  } else if (toastMessageType == ToastMessageType.successMessage) {
    bgColor = Colors.red;
  } else {
    bgColor = Colors.yellow.withLightness(.5);
  }

  Color txColor = textColor ?? Colors.white;

  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.TOP,
      backgroundColor: bgColor,
      textColor: txColor,
      timeInSecForIosWeb: 4,
      fontSize: 16.0.h);
}
