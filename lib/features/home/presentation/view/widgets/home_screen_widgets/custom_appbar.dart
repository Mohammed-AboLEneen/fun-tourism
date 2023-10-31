import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fun_adventure/constants.dart';
import 'package:fun_adventure/cores/utils/screen_dimentions.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomAppBar extends StatelessWidget {
  final void Function()? locationAction;
  final void Function()? menuAction;
  final void Function()? notificationAction;
  final String locationName;

  const CustomAppBar(
      {super.key,
      this.locationAction,
      required this.locationName,
      this.menuAction,
      this.notificationAction});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: context.height * .1,
        width: context.width,
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                  color: mainColor,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(35.w),
                      bottomRight: Radius.circular(35.w))),
            ),
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: EdgeInsets.only(
                  left: 15.w,
                ),
                child: SizedBox(
                  height: context.height * .06,
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: menuAction,
                        child: FaIcon(
                          FontAwesomeIcons.bars,
                          color: Colors.white.withOpacity(.9),
                        ),
                      ),
                      SizedBox(
                        width: context.width * .09,
                      ),
                      SizedBox(
                        width: context.width * .53,
                        child: TextButton(
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.symmetric(horizontal: 4.w),
                            ),
                            onPressed: locationAction,
                            child: locationName.isEmpty
                                ? Center(
                                    child: Text('. . .',
                                        style: TextStyle(
                                            fontSize: 30.sp,
                                            color: Colors.white)),
                                  )
                                : Text(
                                    locationName,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    style: GoogleFonts.notoSansArabic(
                                        fontSize: 20.sp, color: Colors.white),
                                  )),
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            CircleAvatar(
                                backgroundColor: Colors.white.withOpacity(.4),
                                child: GestureDetector(
                                  onTap: () {},
                                  child: FaIcon(
                                    FontAwesomeIcons.magnifyingGlass,
                                    color: Colors.white.withOpacity(.9),
                                    size: 20.h,
                                  ),
                                )),
                            CircleAvatar(
                                backgroundColor: Colors.white.withOpacity(.4),
                                child: GestureDetector(
                                  onTap: notificationAction,
                                  child: FaIcon(
                                    FontAwesomeIcons.bell,
                                    color: Colors.white.withOpacity(.9),
                                  ),
                                ))
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
