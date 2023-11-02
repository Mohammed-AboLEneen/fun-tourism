import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fun_adventure/cores/utils/screen_dimentions.dart';
import 'package:google_fonts/google_fonts.dart';

import 'hot_travel_container_clipper.dart';

class CustomHomeHeader extends StatelessWidget {
  final double h;
  final double w;
  final String header;

  const CustomHomeHeader(
      {super.key, required this.h, required this.w, required this.header});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Row(
        children: [
          ClipPath(
            clipper: CustomHeaderClipper(),
            child: Container(
              color: Colors.cyan,
              height: h,
              width: w,
              child: Padding(
                padding:
                    EdgeInsets.symmetric(vertical: 3.0.h, horizontal: 6.0.w),
                child: Text(
                  header,
                  style: GoogleFonts.akayaKanadaka().copyWith(
                      fontSize: context.height * .027,
                      color: Colors.black.withOpacity(.9)),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
