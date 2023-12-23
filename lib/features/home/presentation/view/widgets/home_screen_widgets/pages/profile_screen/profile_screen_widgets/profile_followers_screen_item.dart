import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fun_adventure/cores/utils/color_degree.dart';
import 'package:fun_adventure/cores/utils/screen_dimentions.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileFollowersScreenItem extends StatelessWidget {
  final void Function()? action;
  final int index;
  final int? currentIndex;

  const ProfileFollowersScreenItem(
      {super.key, this.action, required this.index, this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: action,
      onTap: action,
      behavior: HitTestBehavior.translucent,
      child: Container(
        height: context.height * .35,
        margin: EdgeInsets.only(left: 5.w, right: 5.w, top: 10.h),
        child: Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              height: context.height * .29,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  AnimatedContainer(
                    duration: const Duration(seconds: 1),
                    height: context.height * .29,
                    margin: EdgeInsets.symmetric(horizontal: 10.w),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: LinearGradient(
                          colors: [
                            currentIndex == index
                                ? Colors.cyan.withLightness(.4)
                                : Colors.blue.withLightness(.5),
                            currentIndex == index
                                ? Colors.blue.withLightness(.3)
                                : Colors.indigo
                          ],
                          begin: currentIndex == index
                              ? Alignment.topLeft
                              : Alignment.topRight,
                          end: currentIndex == index
                              ? Alignment.bottomRight
                              : Alignment.bottomLeft),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 30.0.w, vertical: 10.h),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Followers : 30',
                                style: GoogleFonts.aBeeZee(
                                    fontSize: 15.sp,
                                    color: Colors.white.withLightness(.95)),
                              )),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 10.h),
                            child: Container(
                              height: 1,
                              width: context.width * .7,
                              color: Colors.grey.withLightness(.7),
                            ),
                          ),
                          Align(
                              alignment: Alignment.centerRight,
                              child: Text('Travels : 5',
                                  style: GoogleFonts.aBeeZee(
                                    fontSize: 15.sp,
                                    color: Colors.white.withLightness(.95),
                                  ))),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: CircleAvatar(
                radius: context.width * .18,
                backgroundImage: const CachedNetworkImageProvider(
                    'https://th.bing.com/th/id/R.ae37bf7ce4c13212ef0d1ab7d14c179c?rik=0inH4LdrKUvOXA&pid=ImgRaw&r=0'),
              ),
            ),
            Positioned(
              top: context.height * .07,
              right: 3.w,
              child: Container(
                height: 70.h,
                width: context.width * .53,
                margin: EdgeInsets.only(right: 5.w),
                child: Text(
                  'Mohammed Abo L Eneen Ali Elsharkawy',
                  maxLines: 2,
                  style: GoogleFonts.aBeeZee(
                      fontSize: 15.sp, color: Colors.white.withLightness(.95)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
