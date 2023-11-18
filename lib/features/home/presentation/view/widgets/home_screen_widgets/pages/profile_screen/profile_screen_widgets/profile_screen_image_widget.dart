import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fun_adventure/cores/utils/screen_dimentions.dart';

class ProfileScreenImageWidget extends StatelessWidget {
  final String imageUrl;

  const ProfileScreenImageWidget({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        CircleAvatar(
          radius: context.width * .17,
          backgroundColor: Colors.white,
        ),
        CircleAvatar(
          radius: context.width * .16,
          backgroundImage: imageUrl.isNotEmpty ? NetworkImage(imageUrl) : null,
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
