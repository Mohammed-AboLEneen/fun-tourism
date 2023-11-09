import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fun_adventure/cores/utils/color_degree.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextButton extends StatelessWidget {
  final String text;
  final Color? textColor;
  final Color buttonColor;
  final VoidCallback onPressed;
  final Radius? topRight;
  final Radius? topLeft;
  final Radius? bottomRight;
  final Radius? bottomLeft;
  final double textSize;

  const CustomTextButton(
      {super.key,
      required this.text,
      this.textColor,
      required this.buttonColor,
      required this.onPressed,
      this.topRight,
      this.topLeft,
      this.bottomRight,
      this.bottomLeft,
      this.textSize = 20});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: topLeft ?? Radius.zero,
              topRight: topRight ?? Radius.zero,
              bottomRight: bottomRight ?? Radius.zero,
              bottomLeft: bottomLeft ?? Radius.zero,
            ), // Change this value as needed
          ),
        ),
        backgroundColor: MaterialStateProperty.all<Color>(
          buttonColor.withLightness(.55),
        ),
      ),
      child: Text(
        text,
        style: GoogleFonts.akayaKanadaka().copyWith(
            color: textColor?.withLightness(.8), fontSize: textSize.sp),
      ),
    );
  }
}
