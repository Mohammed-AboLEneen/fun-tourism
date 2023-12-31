import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fun_adventure/cores/utils/color_degree.dart';
import 'package:fun_adventure/cores/utils/screen_dimentions.dart';

class ProfileScreenImageWidget extends StatelessWidget {
  final double? whiteCircleRadius;
  final double? imageRadius;
  final String imageUrl;
  final Color? backgroundColor;

  const ProfileScreenImageWidget({
    super.key,
    required this.imageUrl,
    this.whiteCircleRadius,
    this.imageRadius,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        CircleAvatar(
          radius: whiteCircleRadius ?? context.width * .22,
          backgroundColor: backgroundColor ?? Colors.indigo.withLightness(.6),
        ),
        CircleAvatar(
          radius: imageRadius ?? context.width * .21,
          backgroundImage: imageUrl.isEmpty ? null : NetworkImage(imageUrl),
          child: imageUrl.isEmpty
              ? FaIcon(
                  FontAwesomeIcons.user,
                  size: 30.h,
                )
              : null,
        ),
      ],
    );
  }
}
