import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fun_adventure/cores/utils/color_degree.dart';
import 'package:fun_adventure/cores/utils/locator_manger.dart';
import 'package:fun_adventure/cores/utils/screen_dimentions.dart';
import 'package:fun_adventure/features/home/presentation/view_model/main_screen_cubit/main_screen_cubit.dart';
import 'package:fun_adventure/features/home/presentation/view_model/notification_screen_provider/notification_screen_provider.dart';
import 'package:fun_adventure/features/home/presentation/view_model/notifications_listener_provider/notification_listener_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'notification_screen_item.dart';
import 'notification_screen_ui_manger.dart';

class NotificationScreen extends StatefulWidget {
  final NotificationsScreenUiManger notificationsScreenUiManger;
  final void Function()? animatedContainerOnEndMethod;
  final void Function()? onTapBlackContainer;

  const NotificationScreen(
      {super.key,
      this.animatedContainerOnEndMethod,
      required this.notificationsScreenUiManger,
      this.onTapBlackContainer});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  var rng = Random();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Visibility(
          visible:
              widget.notificationsScreenUiManger.notificationScreenIsOpened,
          child: GestureDetector(
            onTap: widget.onTapBlackContainer,
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
            onEnd: widget.animatedContainerOnEndMethod,
            duration: const Duration(milliseconds: 300),
            height: widget.notificationsScreenUiManger.notificationScreenHeight,
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
                      visible: widget.notificationsScreenUiManger
                          .notificationScreenBodyVisible,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  'Notifications',
                                  style: GoogleFonts.abel().copyWith(
                                      fontSize: 30.sp,
                                      fontWeight: FontWeight.w500),
                                ),
                                const Spacer(),
                                IconButton(
                                    onPressed: () {
                                      setState(() {
                                        widget.notificationsScreenUiManger
                                            .closeNotificationScreen(context);
                                      });
                                    },
                                    icon: const FaIcon(
                                      FontAwesomeIcons.xmark,
                                    ))
                              ],
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
                                          index: index);
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
