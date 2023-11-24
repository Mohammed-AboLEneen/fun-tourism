import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fun_adventure/cores/utils/screen_dimentions.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatMassage extends StatelessWidget {
  final String message;

  final Radius? bottomLeft;
  final Radius? bottomRight;

  const ChatMassage(
      {super.key, required this.message, this.bottomLeft, this.bottomRight});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        constraints: BoxConstraints(maxWidth: context.width * .8),
        decoration: BoxDecoration(
            color: const Color(0xffD5E9FE),
            borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(20),
                topRight: const Radius.circular(20),
                bottomLeft: bottomLeft ?? const Radius.circular(20),
                bottomRight: bottomRight ?? const Radius.circular(20))),
        child: Padding(
          padding: EdgeInsets.all(10.h),
          child: Text(
            message,
            style: GoogleFonts.abel().copyWith(fontSize: 17.sp),
          ),
        ),
      ),
    );
  }
}
