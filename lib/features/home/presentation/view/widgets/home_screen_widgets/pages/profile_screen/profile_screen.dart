import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fun_adventure/cores/utils/color_degree.dart';
import 'package:fun_adventure/cores/utils/locator_manger.dart';
import 'package:fun_adventure/cores/utils/routers.dart';
import 'package:fun_adventure/cores/utils/screen_dimentions.dart';
import 'package:fun_adventure/features/home/presentation/view/widgets/home_screen_widgets/pages/profile_screen/profile_screen_follower_item.dart';
import 'package:fun_adventure/features/home/presentation/view_model/main_screen_cubit/main_screen_cubit.dart';
import 'package:fun_adventure/features/home/presentation/view_model/profile_cubit/profile_cubit.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../../../../constants.dart';
import '../../../../../view_model/profile_cubit/profile_states.dart';
import '../../../custom_textbutton.dart';
import '../../hot_travel/travel_item.dart';

class ProfileScreen extends StatelessWidget {
  final String id;

  const ProfileScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileScreenCubit()..profileCubitOperations(id),
      child: BlocConsumer<ProfileScreenCubit, ProfileScreenStates>(
          builder: (context, state) {
            ProfileScreenCubit profileScreenCubit =
                ProfileScreenCubit.get(context);

            if (profileScreenCubit.userName.isNotEmpty ||
                profileScreenCubit.imageUrl.isNotEmpty) {
              return TweenAnimationBuilder(
                  tween: Tween<double>(begin: 0, end: 1),
                  duration: const Duration(seconds: 1),
                  builder: (_, value, __) {
                    return Opacity(
                      opacity: value,
                      child: Scaffold(
                        backgroundColor: Colors.white.withLightness(.95),
                        body: SingleChildScrollView(
                          child: Column(
                            children: [
                              SizedBox(
                                height: context.height * .38,
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
                                            LocatorManager.locator<
                                                        AppMainScreenCubit>()
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
                                        children: [
                                          Stack(
                                            alignment: Alignment.center,
                                            children: [
                                              CircleAvatar(
                                                radius: context.width * .17,
                                                backgroundColor: Colors.white,
                                              ),
                                              CircleAvatar(
                                                radius: context.width * .16,
                                                backgroundImage: NetworkImage(
                                                    profileScreenCubit
                                                        .imageUrl),
                                              ),
                                            ],
                                          ),
                                          Positioned(
                                            bottom: 0,
                                            right: 0,
                                            child: CircleAvatar(
                                              radius: context.width * .06,
                                              child: GestureDetector(
                                                onTap: () {
                                                  profileScreenCubit
                                                      .updateProfileImage();
                                                },
                                                child: FaIcon(
                                                  FontAwesomeIcons.camera,
                                                  size: 25.h,
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    if (profileScreenCubit.isFollowU)
                                      Align(
                                        alignment: Alignment.bottomLeft,
                                        child: Container(
                                          margin: EdgeInsets.only(left: 7.w),
                                          decoration: BoxDecoration(
                                              color:
                                                  Colors.cyan.withLightness(.4),
                                              borderRadius:
                                                  const BorderRadius.only(
                                                topLeft: Radius.circular(10),
                                                bottomRight:
                                                    Radius.circular(10),
                                              )),
                                          child: Padding(
                                            padding: EdgeInsets.all(5.0.w),
                                            child: Text(
                                              'He Is Follow U',
                                              style: GoogleFonts.aBeeZee()
                                                  .copyWith(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Colors.white
                                                          .withLightness(.2)),
                                            ),
                                          ),
                                        ),
                                      )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                  top: 10.0.h,
                                ),
                                child: Text(profileScreenCubit.userName,
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
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10.0.w),
                                          child: CustomTextButton(
                                            text: profileScreenCubit
                                                .followButtonText,
                                            buttonColor: profileScreenCubit
                                                .followButtonColor,
                                            topRight: const Radius.circular(20),
                                            topLeft: const Radius.circular(20),
                                            textSize: 17,
                                            onPressed: () {
                                              profileScreenCubit
                                                  .chooseTheFollowButtonAction(
                                                      id);
                                            },
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10.0.w),
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
                                          'Followers : ',
                                          style: GoogleFonts.abel().copyWith(
                                              fontSize: 20.sp,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          '${profileScreenCubit.followers.length}',
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
                                height: context.height * .23,
                                child: ListView.builder(
                                  padding: EdgeInsets.zero,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) => FollowerItem(
                                    name: profileScreenCubit
                                        .followers[index].name,
                                    imageUrl: profileScreenCubit
                                        .followers[index].imageUrl,
                                    ontap: () {
                                      if (profileScreenCubit
                                              .followers[index].uId !=
                                          uId) {
                                        context.go(
                                            RoutersClass
                                                .fromMainAppScreenToProfileScreen,
                                            extra: profileScreenCubit
                                                .followers[index].uId);
                                      }
                                    },
                                  ),
                                  itemCount:
                                      profileScreenCubit.followers.length,
                                ),
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
                                        hotTravelModel: LocatorManager.locator<
                                                AppMainScreenCubit>()
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
                      ),
                    );
                  });
            } else if (state is FailureGetProfileScreenDataState) {
              return Scaffold(
                body: Center(
                  child: Text(
                    'There is a failure',
                    style: GoogleFonts.aBeeZee().copyWith(fontSize: 30.sp),
                  ),
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
