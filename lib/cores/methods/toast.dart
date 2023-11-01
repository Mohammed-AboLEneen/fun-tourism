import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

void showToast({required String msg, required bool isFailure}) {
  Color bgColor = isFailure ? Colors.red : Colors.green;
  Color txColor = Colors.white;

  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.TOP,
      backgroundColor: bgColor,
      textColor: txColor,
      timeInSecForIosWeb: 4,
      fontSize: 16.0.h);
}
