import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fun_adventure/cores/models/follower_model/follower_model.dart';
import 'package:fun_adventure/cores/utils/color_degree.dart';
import 'package:fun_adventure/cores/utils/screen_dimentions.dart';
import 'package:fun_adventure/features/home/presentation/view/widgets/home_screen_widgets/pages/profile_screen/profile_screen_widgets/profile_screen_image_widget.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../custom_textbutton.dart';
import '../profile_screen.dart';

class ProfileFollowersScreenItem extends StatelessWidget {
  final void Function()? action;
  final int index;
  final int? currentIndex;
  final FollowerModel followerModel;

  const ProfileFollowersScreenItem(
      {super.key,
      this.action,
      required this.index,
      this.currentIndex,
      required this.followerModel});

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
              height: context.height * .27,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  AnimatedContainer(
                    duration: const Duration(seconds: 1),
                    height: context.height * .27,
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
                    child: AnimatedOpacity(
                      opacity: currentIndex == index ? 0 : 1,
                      duration: const Duration(seconds: 1),
                      child: Container(
                          margin: EdgeInsets.symmetric(
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
                          )),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: EdgeInsets.only(top: context.height * .06),
                      child: AnimatedOpacity(
                        opacity: currentIndex == index ? 1 : 0,
                        duration: const Duration(seconds: 1),
                        child: ClipRRect(
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                            child: CustomTextButton(
                                text: 'Browse',
                                buttonColor: Colors.transparent.withOpacity(.1),
                                buttonColorLightness: .4,
                                topRight: 0,
                                topLeft: 20,
                                bottomLeft: 20,
                                bottomRight: 20,
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    PageRouteBuilder(
                                        transitionDuration:
                                            const Duration(milliseconds: 500),
                                        reverseTransitionDuration:
                                            const Duration(milliseconds: 500),
                                        pageBuilder: (context, animation,
                                                secondaryAnimation) =>
                                            ProfileScreen(
                                              heroTag: followerModel.uId,
                                              showLoadingIndicator: true,
                                            ),
                                        settings: RouteSettings(
                                            arguments: followerModel.uId)),
                                  );
                                }),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: ProfileScreenImageWidget(
                imageUrl: followerModel.imageUrl ??
                    'https://th.bing.com/th/id/R.ae37bf7ce4c13212ef0d1ab7d14c179c?rik=0inH4LdrKUvOXA&pid=ImgRaw&r=0',
                whiteCircleRadius: context.width * .19,
                imageRadius: context.width * .18,
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
                  followerModel.followerName ?? '',
                  maxLines: 3,
                  style: GoogleFonts.aBeeZee(
                      fontSize: 18.sp, color: Colors.white.withLightness(.95)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
