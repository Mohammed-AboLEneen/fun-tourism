import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fun_adventure/cores/utils/locator_manger.dart';
import 'package:fun_adventure/cores/utils/screen_dimentions.dart';
import 'package:fun_adventure/features/home/presentation/view_model/main_screen_cubit/main_screen_cubit.dart';
import 'package:provider/provider.dart';

import '../../view_model/notifications_listener_provider/notification_listener_provider.dart';

class CustomBottomNavigationBarItem extends StatelessWidget {
  final IconData icon;
  final void Function() onTap;
  final int index;
  final int currentIndex;

  const CustomBottomNavigationBarItem(
      {super.key,
      required this.icon,
      required this.onTap,
      required this.currentIndex,
      required this.index});

  @override
  Widget build(BuildContext context) {
    return Consumer<NotificationListenerProvider>(builder: (_, model, __) {
      return GestureDetector(
        onTap: onTap,
        child: Container(
          width: context.width * .2,
          margin: EdgeInsets.symmetric(vertical: 4.h),
          child: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
            Expanded(
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: FaIcon(
                      icon,
                      color: Colors.white.withOpacity(.5),
                      size: 24.h,
                    ),
                  ),
                  if (index == 1 &&
                      (LocatorManager.locator<AppMainScreenCubit>()
                              .userNotifications
                              ?.isNotEmpty ??
                          false))
                    Positioned(
                      top: 5.h,
                      left: context.width * .056,
                      child: SizedBox(
                        height: 16.h,
                        width: 16.w,
                        child: CircleAvatar(
                          backgroundColor: Colors.red,
                          child: Consumer<NotificationListenerProvider>(
                            builder: (_, model, __) {
                              return Text(
                                '${model.notificationsNumber}',
                                style: TextStyle(
                                    fontSize: 10.sp,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              );
                            },
                          ),
                        ),
                      ),
                    )
                ],
              ),
            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 700),
              margin: EdgeInsets.only(top: 7.h),
              color: Colors.blue.withOpacity(.9),
              width: index == currentIndex ? 20.w : 0,
              height: index == currentIndex ? 2.h : 0,
            ),
          ]),
        ),
      );
    });
  }
}
