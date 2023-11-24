import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fun_adventure/cores/models/notification_model/notification_model.dart';
import 'package:fun_adventure/cores/utils/color_degree.dart';
import 'package:fun_adventure/cores/utils/locator_manger.dart';
import 'package:fun_adventure/cores/utils/screen_dimentions.dart';
import 'package:fun_adventure/features/home/presentation/view_model/main_screen_cubit/main_screen_cubit.dart';
import 'package:fun_adventure/features/home/presentation/view_model/notification_screen_provider/notification_screen_provider.dart';
import 'package:fun_adventure/features/home/presentation/view_model/notifications_listener_provider/notification_listener_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'notification_screen_ui_manger.dart';

class NotificationScreen extends StatelessWidget {
  final NotificationsScreenUiManger notificationsScreenUiManger;
  final void Function()? animatedContainerOnEndMethod;
  final void Function()? onTapBlackContainer;

  const NotificationScreen(
      {super.key,
      this.animatedContainerOnEndMethod,
      required this.notificationsScreenUiManger,
      this.onTapBlackContainer});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Visibility(
          visible: notificationsScreenUiManger.notificationScreenIsOpened,
          child: GestureDetector(
            onTap: onTapBlackContainer,
            child: Container(
              width: context.width,
              height: context.height,
              color: Colors.black.withOpacity(.6),
            ),
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: AnimatedContainer(
            onEnd: animatedContainerOnEndMethod,
            duration: const Duration(milliseconds: 300),
            height: notificationsScreenUiManger.notificationScreenHeight,
            width: context.width * .9,
            decoration: BoxDecoration(
                color: Colors.indigo.withLightness(.95),
                borderRadius: const BorderRadius.all(Radius.circular(20))),
            child: ChangeNotifierProvider(
              create: (context) => NotificationScreenProvider()
                ..requestUserNotifications(context),
              child: Consumer<NotificationScreenProvider>(
                builder: (_, model, __) {
                  if (model.finishToRequestNotifications) {
                    return Visibility(
                      visible: notificationsScreenUiManger
                          .notificationScreenBodyVisible,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Notifications',
                              style: GoogleFonts.abel().copyWith(
                                  fontSize: 30.sp, fontWeight: FontWeight.w500),
                            ),
                            Consumer<NotificationListenerProvider>(
                              builder: (_, model, __) {
                                return Expanded(
                                  child: ListView.separated(
                                    itemBuilder: (context, index) {
                                      return NotificationScreenItem(
                                        notificationModel: LocatorManager
                                                .locator<AppMainScreenCubit>()
                                            .userNotifications[index],
                                      );
                                    },
                                    separatorBuilder: (context, index) {
                                      return Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: context.width * .01),
                                        child: Container(
                                          height: 1,
                                          color: Colors.grey,
                                        ),
                                      );
                                    },
                                    itemCount: LocatorManager.locator<
                                            AppMainScreenCubit>()
                                        .userNotifications
                                        .length,
                                  ),
                                );
                              },
                            )
                          ],
                        ),
                      ),
                    );
                  } else {
                    return Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 70.0.w),
                        child: LinearProgressIndicator(
                          color: Colors.indigo,
                          borderRadius: BorderRadius.circular(20),
                          backgroundColor: Colors.grey,
                        ),
                      ),
                    );
                  }
                },
              ),
            ),
          ),
        )
      ],
    );
  }
}

class NotificationScreenItem extends StatelessWidget {
  final NotificationModel notificationModel;

  const NotificationScreenItem({super.key, required this.notificationModel});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.height * .1,
      child: Row(
        children: [
          SizedBox(
            height: context.height,
            width: context.width * .17,
            child: CircleAvatar(
              backgroundImage: NetworkImage(
                  notificationModel.notificationData.imageUrl ?? ''),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  notificationModel.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.abel().copyWith(fontSize: 15.sp),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        notificationModel.body,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.abel().copyWith(
                            fontSize: 14.sp,
                            color: Colors.grey.withLightness(.4)),
                      ),
                    ),
                    const Spacer(),
                    SizedBox(
                        width: 40.w,
                        child: Text(
                          notificationModel.notificationData.time ?? '---',
                          style: GoogleFonts.akayaKanadaka()
                              .copyWith(fontSize: 15.sp),
                        ))
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
