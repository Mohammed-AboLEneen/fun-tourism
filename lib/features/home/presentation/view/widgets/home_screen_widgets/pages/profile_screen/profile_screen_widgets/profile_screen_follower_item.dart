import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fun_adventure/cores/utils/screen_dimentions.dart';
import 'package:google_fonts/google_fonts.dart';

class FollowerItem extends StatelessWidget {
  final String? name;
  final String? imageUrl;
  final void Function()? ontap;

  const FollowerItem(
      {super.key, required this.name, required this.imageUrl, this.ontap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 15.0.w),
      child: GestureDetector(
        onTap: ontap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundImage:
                  imageUrl!.isNotEmpty ? NetworkImage(imageUrl!) : null,
              radius: context.width * .11,
              child: imageUrl!.isEmpty
                  ? FaIcon(
                      FontAwesomeIcons.user,
                      size: context.width * .11,
                    )
                  : null,
            ),
            SizedBox(
              height: 5.h,
            ),
            SizedBox(
              width: context.width * .23,
              child: Text(
                name ?? '',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.abel()
                    .copyWith(fontSize: 18.sp, fontWeight: FontWeight.w600),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
