import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fun_adventure/cores/utils/screen_dimentions.dart';

class CustomAnimatedIndicatorProgress extends StatelessWidget {

  final int imageUploadProgress;

  const CustomAnimatedIndicatorProgress(
      {super.key, required this.imageUploadProgress});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      alignment:
      Alignment.bottomLeft,
      duration: const Duration(
          milliseconds: 500),
      height: 5.h,
      width: (context.width * .7) *
          (imageUploadProgress /
              100),
      constraints: BoxConstraints(
          maxWidth:
          context.width * .7),
      decoration: BoxDecoration(
        color: Colors.indigo,
        borderRadius:
        BorderRadius.circular(
            20),
      ),
    );
  }
}
