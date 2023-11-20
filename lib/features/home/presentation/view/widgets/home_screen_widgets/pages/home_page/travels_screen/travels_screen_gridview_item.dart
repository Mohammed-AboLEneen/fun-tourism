import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fun_adventure/cores/utils/color_degree.dart';
import 'package:fun_adventure/cores/utils/screen_dimentions.dart';
import 'package:fun_adventure/features/home/presentation/view/widgets/custom_textbutton.dart';
import 'package:google_fonts/google_fonts.dart';

import 'gridview_border_radius.dart';

class TravelsScreenGridViewItem extends StatefulWidget {
  final bool isSelected;
  final String imageUrl;
  final double radius;

  const TravelsScreenGridViewItem(
      {super.key,
      required this.imageUrl,
      required this.radius,
      required this.isSelected});

  @override
  State<TravelsScreenGridViewItem> createState() =>
      _TravelsScreenGridViewItemState();
}

class _TravelsScreenGridViewItemState extends State<TravelsScreenGridViewItem>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: context.height,
          width: context.width,
          child: Card(
            color: Colors.white,
            margin: EdgeInsets.zero,
            child: AnimatedScale(
              scale: widget.isSelected ? 1.1 : 1,
              duration: const Duration(milliseconds: 500),
              child: ClipRRect(
                borderRadius: customBorderRadius(widget.radius),
                child: Image.network(
                  widget.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
        AnimatedOpacity(
          opacity: widget.isSelected ? 1 : 0,
          duration: const Duration(milliseconds: 500),
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 2,
              sigmaY: 2,
            ),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: customBorderRadius(widget.radius)),
            ),
          ),
        ),
        if (widget.isSelected)
          SizedBox(
            width: context.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TweenAnimationBuilder(
                  duration: const Duration(milliseconds: 1000),
                  tween: Tween<Offset>(
                      begin: const Offset(0, -10), end: const Offset(0, 0)),
                  builder: (BuildContext context, Offset value, Widget? child) {
                    return Transform.translate(
                      offset: value,
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 2000),
                        height: context.height * (((value.dy) * -1) / 10) * .1,
                        constraints:
                            BoxConstraints(maxWidth: context.width * .4),
                        decoration: BoxDecoration(
                            color: const Color(0xff313745).withOpacity(.8),
                            borderRadius: customBorderRadius(5)),
                        padding: EdgeInsets.all(5.h),
                        child: Text(
                          'Marsa Matroh',
                          style: GoogleFonts.abel().copyWith(
                              color: Colors.white.withLightness(.9),
                              fontSize: 18.sp),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(
                  height: 10.h,
                ),
                TweenAnimationBuilder(
                  duration: const Duration(milliseconds: 1500),
                  tween: Tween<Offset>(
                      begin: const Offset(0, -7), end: const Offset(0, 0)),
                  builder: (BuildContext context, Offset value, Widget? child) {
                    return Transform.translate(
                      offset: value,
                      child: child,
                    );
                  },
                  child: CustomTextButton(
                    text: 'More Info',
                    buttonColor: const Color(0xff313745).withOpacity(.8),
                    onPressed: () {},
                    topLeft: 10,
                    topRight: 10,
                    bottomRight: 10,
                    bottomLeft: 10,
                    textSize: 15.sp,
                    buttonColorLightness: .3,
                  ),
                ),
              ],
            ),
          )
      ],
    );
  }
}