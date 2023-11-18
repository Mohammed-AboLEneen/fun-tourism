import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fun_adventure/cores/utils/color_degree.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomContainer extends StatelessWidget {

  final String text;
  final Color backgroundColor;
  final Radius? topLeftRadius;
  final Radius? bottomRightRadius;
  final Radius? bottomLeftRadius;
  final Radius? topRightRadius;

  const CustomContainer(
      {super.key, required this.backgroundColor, this.topLeftRadius, this.bottomRightRadius, this.bottomLeftRadius, this.topRightRadius, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 7.w),
      decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius:
          BorderRadius.only(
              topLeft: topLeftRadius ?? Radius.zero,
              bottomRight: bottomRightRadius ?? Radius.zero,
              topRight: topRightRadius ?? Radius.zero,
              bottomLeft: bottomLeftRadius ?? Radius.zero
          )),
      child: Padding(
        padding: EdgeInsets.all(5.0.w),
        child: Text(
          text,
          style: GoogleFonts.aBeeZee()
              .copyWith(
              fontWeight:
              FontWeight.w500,
              color: Colors.white
                  .withLightness(.2)),
        ),
      ),
    );
  }
}
