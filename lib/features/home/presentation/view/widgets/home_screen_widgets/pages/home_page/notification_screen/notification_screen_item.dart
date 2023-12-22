import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fun_adventure/cores/utils/color_degree.dart';
import 'package:fun_adventure/cores/utils/screen_dimentions.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../../../../../cores/models/notification_model/notification_model.dart';
import '../../profile_screen/profile_screen.dart';

class NotificationScreenItem extends StatelessWidget {
  final NotificationModel notificationModel;
  final int index;

  const NotificationScreenItem(
      {super.key, required this.notificationModel, required this.index});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            PageRouteBuilder(
              transitionDuration: const Duration(milliseconds: 700),
              reverseTransitionDuration: const Duration(milliseconds: 700),
              pageBuilder: (context, animation, secondaryAnimation) =>
                  ProfileScreen(
                heroTag: 'notification$index',
              ),
              settings: RouteSettings(
                  arguments: notificationModel.notificationData.contentId),
            ));
      },
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 3.0.h),
        child: Row(
          children: [
            SizedBox(
              height: context.height * .11,
              width: context.width * .21,
              child: Hero(
                tag: 'notification$index',
                child: CircleAvatar(
                  backgroundImage: CachedNetworkImageProvider(
                      notificationModel.notificationData.imageUrl ?? '',
                      errorListener: (error) {}),
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    notificationModel.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.abel()
                        .copyWith(fontSize: 15.sp, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          notificationModel.body,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.abel().copyWith(
                              fontSize: 17.sp,
                              color: Colors.grey.withLightness(.4)),
                        ),
                      ),
                      SizedBox(
                          width: 50.w,
                          child: Center(
                            child: Text(
                              notificationModel.notificationData.time ?? '---',
                              style: GoogleFonts.akayaKanadaka()
                                  .copyWith(fontSize: 16.sp),
                            ),
                          ))
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
