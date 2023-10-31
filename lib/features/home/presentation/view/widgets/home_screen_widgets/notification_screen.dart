import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fun_adventure/cores/utils/color_degree.dart';
import 'package:fun_adventure/cores/utils/screen_dimentions.dart';
import 'package:fun_adventure/features/home/presentation/view_model/home_screen_cubit/home_screen_cubit.dart';
import 'package:google_fonts/google_fonts.dart';

class NotificationScreen extends StatelessWidget {
  final HomeScreenCubit homeScreenCubit;
  final void Function()? animatedContainerOnEndMethod;

  const NotificationScreen(
      {super.key,
      required this.homeScreenCubit,
      this.animatedContainerOnEndMethod});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Visibility(
          visible: homeScreenCubit.notificationScreenIsOpened,
          child: GestureDetector(
            onTap: () {
              homeScreenCubit.closeNotificationScreen(context);
            },
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
            height: homeScreenCubit.notificationScreenHeight,
            width: context.width * .9,
            decoration: BoxDecoration(
                color: Colors.indigo.withLightness(.95),
                borderRadius: const BorderRadius.all(Radius.circular(20))),
            child: Visibility(
              visible: homeScreenCubit.notificationScreenBodyVisible,
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
                    Expanded(
                      child: ListView.separated(
                        itemBuilder: (context, index) {
                          return SizedBox(
                            height: context.height * .1,
                            child: Row(
                              children: [
                                SizedBox(
                                  height: context.height,
                                  width: context.width * .17,
                                  child: const CircleAvatar(
                                    backgroundImage: NetworkImage(
                                        'https://th.bing.com/th/id/R.10f2a49c0941a8cd3d1ac373142b75e6?rik=EOj%2f4XT4DYN%2bOw&riu=http%3a%2f%2fimages4.fanpop.com%2fimage%2fphotos%2f16200000%2fGogeta-wallpaper-1-dragonball-z-movie-characters-16255512-1024-768.jpg&ehk=rUAz6nuX0%2bq50k3aYpgnDERm1GE7cpb2RHftpMaoLT4%3d&risl=&pid=ImgRaw&r=0'),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'This Is Just A Test' * 3,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: GoogleFonts.abel()
                                            .copyWith(fontSize: 15.sp),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              'no man is in the life man' * 3,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: GoogleFonts.abel()
                                                  .copyWith(
                                                      fontSize: 14.sp,
                                                      color: Colors.grey
                                                          .withLightness(.4)),
                                            ),
                                          ),
                                          SizedBox(
                                              width: 60.w,
                                              child: Text(
                                                '18:23 Am',
                                                style:
                                                    GoogleFonts.akayaKanadaka()
                                                        .copyWith(
                                                            fontSize: 15.sp),
                                              ))
                                        ],
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
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
                        itemCount: 10,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
