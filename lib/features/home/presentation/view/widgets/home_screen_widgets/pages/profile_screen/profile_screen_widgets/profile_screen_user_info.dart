import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fun_adventure/cores/models/user_data_info/user_info_data.dart';
import 'package:fun_adventure/cores/utils/screen_dimentions.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileScreenUserInformation extends StatelessWidget {
  final UserInfoData? userInfoData;

  const ProfileScreenUserInformation({super.key, required this.userInfoData});

  @override
  Widget build(BuildContext context) {
    return (userInfoData?.displayName?.isNotEmpty ?? false) &&
            (userInfoData?.email?.isNotEmpty ?? false)
        ? Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0.w),
                child: Row(
                  children: [
                    FaIcon(
                      FontAwesomeIcons.fileSignature,
                      size: 17.h,
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          userInfoData?.displayName ?? '',
                          maxLines: 5,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.aBeeZee().copyWith(
                              fontSize: 17.sp, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: context.width * .17, vertical: 10.h),
                child: const Divider(
                  height: 1,
                  color: Colors.grey,
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0.w),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          userInfoData?.email ?? '',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.aBeeZee().copyWith(
                            fontSize: 17.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      FaIcon(
                        FontAwesomeIcons.google,
                        size: 17.h,
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: context.width * .17, vertical: 10.h),
                child: const Divider(
                  height: 1,
                  color: Colors.grey,
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0.w),
                  child: Row(
                    children: [
                      FaIcon(
                        FontAwesomeIcons.phoneFlip,
                        size: 17.h,
                      ),
                      const Spacer(),
                      Text(
                        userInfoData?.phoneNumber ?? '',
                        style: GoogleFonts.aBeeZee().copyWith(
                            fontSize: 17.sp, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              ),
            ],
          )
        : Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 30.h),
              child: const LinearProgressIndicator(
                color: Colors.indigo,
              ),
            ),
          );
  }
}
