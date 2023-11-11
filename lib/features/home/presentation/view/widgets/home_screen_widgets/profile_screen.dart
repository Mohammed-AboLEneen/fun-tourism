import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fun_adventure/cores/utils/color_degree.dart';
import 'package:fun_adventure/cores/utils/locator_manger.dart';
import 'package:fun_adventure/cores/utils/routers.dart';
import 'package:fun_adventure/cores/utils/screen_dimentions.dart';
import 'package:fun_adventure/features/home/presentation/view_model/main_screen_cubit/main_screen_cubit.dart';
import 'package:fun_adventure/features/home/presentation/view_model/profile_cubit/profile_cubit.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../../constants.dart';
import '../../../view_model/profile_cubit/profile_states.dart';
import '../custom_textbutton.dart';
import 'hot_travel/travel_item.dart';

class ProfileScreen extends StatelessWidget {
  final String id;

  const ProfileScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileScreenCubit()..getUserData(id),
      child: BlocConsumer<ProfileScreenCubit, ProfileScreenStates>(
          builder: (context, state) {
            ProfileScreenCubit profileScreenCubit =
                ProfileScreenCubit.get(context);

            print(profileScreenCubit.userName);
            print(profileScreenCubit.imageUrl);
            if (profileScreenCubit.userName != null ||
                profileScreenCubit.imageUrl != null) {
              return Scaffold(
                backgroundColor: Colors.white.withLightness(.95),
                body: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: context.height * .37,
                        child: Stack(
                          children: [
                            Container(
                              width: context.width,
                              height: context.height * .32,
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.only(
                                  bottomRight: Radius.circular(15),
                                  bottomLeft: Radius.circular(15),
                                ),
                                image: DecorationImage(
                                  image: NetworkImage(
                                    LocatorManager.locator<AppMainScreenCubit>()
                                            .userData
                                            ?.userInfoData
                                            .photoURL ??
                                        '',
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  CircleAvatar(
                                    radius: context.width * .15,
                                    backgroundColor: Colors.white,
                                  ),
                                  CircleAvatar(
                                    radius: context.width * .14,
                                    backgroundImage: NetworkImage(
                                        profileScreenCubit.imageUrl ?? ''),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: 10.0.h,
                        ),
                        child: Text(profileScreenCubit.userName ?? '',
                            style: GoogleFonts.abel().copyWith(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 20,
                            ),
                            textAlign: TextAlign.center),
                      ),
                      if (id != uId)
                        Padding(
                          padding: EdgeInsets.only(top: 20.h),
                          child: Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 10.0.w),
                                  child: CustomTextButton(
                                    text: 'Follow',
                                    buttonColor: Colors.indigo,
                                    topRight: const Radius.circular(20),
                                    topLeft: const Radius.circular(20),
                                    textSize: 17,
                                    onPressed: () {
                                      profileScreenCubit
                                          .sendFollowDataToFireStore(id);
                                    },
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 10.0.w),
                                  child: CustomTextButton(
                                    text: 'Send Message',
                                    buttonColor: Colors.indigo,
                                    topRight: const Radius.circular(20),
                                    topLeft: const Radius.circular(20),
                                    textSize: 17,
                                    onPressed: () {},
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: Row(
                              children: [
                                Text(
                                  'Friends : ',
                                  style: GoogleFonts.abel().copyWith(
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  '122',
                                  style: GoogleFonts.abel().copyWith(
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          )),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: context.height * .15,
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                context.go(
                                    RoutersClass
                                        .fromMainAppScreenToProfileScreen,
                                    extra: '08iLv9b16EXZTJGURmT4TRPzq7n1');
                              },
                              child: Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 10.0.w),
                                  child: SizedBox(
                                    width: context.width * .2,
                                    child: Column(
                                      children: [
                                        CircleAvatar(
                                          radius: context.width * .1,
                                          backgroundImage: const NetworkImage(
                                              'https://i.pinimg.com/originals/32/db/ad/32dbadaa9bf670b5258cbebce3ecd240.jpg'),
                                        ),
                                        Expanded(
                                          child: Text(
                                            'Mohammed Abo L Eneen Ali',
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: GoogleFonts.abel().copyWith(
                                                fontSize: 15.sp,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        )
                                      ],
                                    ),
                                  )),
                            ),
                            Padding(
                                padding:
                                    EdgeInsets.symmetric(horizontal: 10.0.w),
                                child: SizedBox(
                                  width: context.width * .2,
                                  child: Column(
                                    children: [
                                      CircleAvatar(
                                        radius: context.width * .1,
                                        backgroundImage: const NetworkImage(
                                            'https://i.pinimg.com/originals/32/db/ad/32dbadaa9bf670b5258cbebce3ecd240.jpg'),
                                      ),
                                      Expanded(
                                        child: Text(
                                          'Mohammed Abo L Eneen Ali',
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: GoogleFonts.abel().copyWith(
                                              fontSize: 15.sp,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      )
                                    ],
                                  ),
                                ))
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                        child: Divider(
                          height: 1,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: Row(
                              children: [
                                Text(
                                  'Travels : ',
                                  style: GoogleFonts.abel().copyWith(
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  '10',
                                  style: GoogleFonts.abel().copyWith(
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          )),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      SizedBox(
                        height: context.height * .3,
                        child: ListView.builder(
                          itemBuilder: (context, state) {
                            return Padding(
                              padding: const EdgeInsets.all(10),
                              child: TravelItem(
                                hotTravelModel:
                                    LocatorManager.locator<AppMainScreenCubit>()
                                        .hotTravels[0],
                              ),
                            );
                          },
                          itemCount: 10,
                          scrollDirection: Axis.horizontal,
                        ),
                      ),
                      SizedBox(
                        height: context.height * .1,
                      )
                    ],
                  ),
                ),
              );
            } else if (state is FailureGetProfileScreenDataState) {
              return Center(
                child: Text(
                  'There is a failure',
                  style: GoogleFonts.aBeeZee().copyWith(fontSize: 30.sp),
                ),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
          listener: (context, state) {}),
    );
  }
}
