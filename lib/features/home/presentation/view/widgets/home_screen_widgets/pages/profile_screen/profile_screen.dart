import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fun_adventure/cores/utils/color_degree.dart';
import 'package:fun_adventure/cores/utils/locator_manger.dart';
import 'package:fun_adventure/cores/utils/routers.dart';
import 'package:fun_adventure/cores/utils/screen_dimentions.dart';
import 'package:fun_adventure/features/home/presentation/view/widgets/home_screen_widgets/pages/profile_screen/profile_screen_widgets/custom_animated_indicator_progress.dart';
import 'package:fun_adventure/features/home/presentation/view/widgets/home_screen_widgets/pages/profile_screen/profile_screen_widgets/profile_screen_follower_item.dart';
import 'package:fun_adventure/features/home/presentation/view/widgets/home_screen_widgets/pages/profile_screen/profile_screen_widgets/profile_screen_image_widget.dart';
import 'package:fun_adventure/features/home/presentation/view_model/main_screen_cubit/main_screen_cubit.dart';
import 'package:fun_adventure/features/home/presentation/view_model/profile_cubit/profile_cubit.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../../../../constants.dart';
import '../../../../../../../../cores/methods/show_image_dialog.dart';
import '../../../../../../../../cores/utils/custom_container.dart';
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
                        appBar: AppBar(
                          backgroundColor: Colors.white.withLightness(.95),
                        ),
                        backgroundColor: Colors.white.withLightness(.95),
                        body: SingleChildScrollView(
                          child: Column(
                            children: [
                              Stack(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      showImageDialog(
                                          context, profileScreenCubit.imageUrl);
                                    },
                                    child: ProfileScreenImageWidget(
                                      imageUrl: profileScreenCubit.imageUrl,
                                    ),
                                  ),
                                  if (id == uId)
                                    Positioned(
                                      bottom: 0,
                                      right: 0,
                                      child: CircleAvatar(
                                        radius: context.width * .06,
                                        backgroundColor:
                                            Colors.indigo.withLightness(.8),
                                        child: GestureDetector(
                                          onTap: () {
                                            profileScreenCubit
                                                .updateProfileImage(context);
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
                              if (profileScreenCubit.isFollowU)
                                Padding(
                                  padding: EdgeInsets.only(top: 10.h),
                                  child: CustomContainer(
                                    text: 'He Follow U',
                                    backgroundColor:
                                        Colors.cyan.withLightness(.4),
                                    topLeftRadius: const Radius.circular(10),
                                    bottomRightRadius:
                                        const Radius.circular(10),
                                  ),
                                ),
                              if (id == uId)
                                Stack(
                                  children: [
                                    AnimatedContainer(
                                      duration:
                                          const Duration(milliseconds: 700),
                                      height: profileScreenCubit
                                                  .imageUploadProgress >
                                              0
                                          ? context.height * .055
                                          : 0,
                                      width: context.width,
                                    ),
                                    Visibility(
                                      visible: profileScreenCubit
                                              .imageUploadProgress >
                                          0,
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            left: 30.w, right: 10.w, top: 10.h),
                                        child: SizedBox(
                                          height: context.height * .05,
                                          child: Row(
                                            children: [
                                              CustomAnimatedIndicatorProgress(
                                                  imageUploadProgress:
                                                      profileScreenCubit
                                                          .imageUploadProgress),
                                              const Spacer(),
                                              SizedBox(
                                                width: context.width * .1,
                                                child: Text(
                                                    '${profileScreenCubit.imageUploadProgress} %'),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
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
                              if (profileScreenCubit.imageUploadProgress == 0)
                                SizedBox(
                                  height: 15.h,
                                ),
                              Row(
                                children: [
                                  Expanded(
                                      child: Padding(
                                    padding: EdgeInsets.only(left: 15.0.w),
                                    child: Row(
                                      children: [
                                        Text(
                                          'Followers : ',
                                          style: GoogleFonts.akayaKanadaka()
                                              .copyWith(
                                                  fontSize: 22.sp,
                                                  fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          '${profileScreenCubit.followers.length}',
                                          style: GoogleFonts.abel().copyWith(
                                              fontSize: 17.sp,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ],
                                    ),
                                  )),
                                ],
                              ),
                              SizedBox(
                                height: profileScreenCubit.followers.isEmpty
                                    ? 20.h
                                    : context.height * .23,
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
                              Row(
                                children: [
                                  Expanded(
                                      child: Padding(
                                    padding: EdgeInsets.only(
                                        left: 15.0.w, top: 15.h),
                                    child: Row(
                                      children: [
                                        Text(
                                          'Travels : ',
                                          style: GoogleFonts.akayaKanadaka()
                                              .copyWith(
                                                  fontSize: 22.sp,
                                                  fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          '10',
                                          style: GoogleFonts.abel().copyWith(
                                              fontSize: 17.sp,
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
                    'There Is An Error',
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
