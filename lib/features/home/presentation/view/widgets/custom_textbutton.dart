import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fun_adventure/cores/utils/color_degree.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextButton extends StatelessWidget {
  final String text;
  final Color? textColor;
  final Color buttonColor;
  final VoidCallback onPressed;
  final double? topRight;
  final double? topLeft;
  final double? bottomRight;
  final double? bottomLeft;
  final double textSize;
  final double? buttonColorLightness;
  final double? textColorLightness;

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
      this.textSize = 20,
      this.buttonColorLightness,
      this.textColorLightness});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(topLeft ?? 0),
              topRight: Radius.circular(topRight ?? 0),
              bottomRight: Radius.circular(bottomRight ?? 0),
              bottomLeft: Radius.circular(bottomLeft ?? 0),
            ), // Change this value as needed
          ),
        ),
        backgroundColor: MaterialStateProperty.all<Color>(
          buttonColor.withLightness(buttonColorLightness ?? .8),
        ),
      ),
      child: Text(
        text,
        style: GoogleFonts.akayaKanadaka().copyWith(
            color: textColor?.withLightness(textColorLightness ?? .8),
            fontSize: textSize.sp),
      ),
    );
  }
}
