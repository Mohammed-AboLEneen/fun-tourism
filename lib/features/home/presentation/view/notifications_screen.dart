import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fun_adventure/cores/utils/screen_dimentions.dart';
import 'package:fun_adventure/features/home/presentation/view/widgets/notifications_screen_item.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../../cores/utils/locator_manger.dart';
import '../view_model/main_screen_cubit/main_screen_cubit.dart';
import '../view_model/notifications_listener_provider/notification_listener_provider.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Builder(builder: (context) {
        if (LocatorManager.locator<AppMainScreenCubit>().userNotifications !=
            null) {
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Notifications',
                  style: GoogleFonts.aboreto()
                      .copyWith(fontSize: 25.sp, fontWeight: FontWeight.w500),
                ),
                Consumer<NotificationListenerProvider>(
                  builder: (_, model, __) {
                    return Expanded(
                      child: ListView.separated(
                        itemBuilder: (context, index) {
                          return NotificationScreenItem(
                              notificationModel:
                                  LocatorManager.locator<AppMainScreenCubit>()
                                      .userNotifications![index],
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
                        itemCount: LocatorManager.locator<AppMainScreenCubit>()
                                .userNotifications
                                ?.length ??
                            0,
                      ),
                    );
                  },
                )
              ],
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
      }),
    );
  }
}
