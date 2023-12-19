import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fun_adventure/cores/utils/color_degree.dart';
import 'package:fun_adventure/cores/utils/custom_textfield_rounded_border.dart';
import 'package:fun_adventure/cores/utils/locator_manger.dart';
import 'package:fun_adventure/cores/utils/screen_dimentions.dart';
import 'package:fun_adventure/features/home/presentation/view/widgets/custom_textbutton.dart';
import 'package:fun_adventure/features/home/presentation/view/widgets/home_screen_widgets/pages/profile_screen/edit_screen.dart';
import 'package:fun_adventure/features/home/presentation/view/widgets/home_screen_widgets/pages/profile_screen/profile_screen_widgets/custom_animated_indicator_progress.dart';
import 'package:fun_adventure/features/home/presentation/view/widgets/home_screen_widgets/pages/profile_screen/profile_screen_widgets/profile_screen_image_widget.dart';
import 'package:fun_adventure/features/home/presentation/view_model/main_screen_cubit/main_screen_cubit.dart';
import 'package:fun_adventure/features/home/presentation/view_model/profile_cubit/profile_cubit.dart';
import 'package:fun_adventure/features/home/presentation/view_model/profile_cubit/profile_states.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../../../../../constants.dart';
import '../../../../../../../../../cores/methods/show_image_dialog.dart';
import '../../../../../../../../../cores/utils/custom_container.dart';
import 'follow_button.dart';

class ProfileScreenBody extends StatefulWidget {
  final String id;

  const ProfileScreenBody({super.key, required this.id});

  @override
  State<ProfileScreenBody> createState() => _ProfileScreenBodyState();
}

class _ProfileScreenBodyState extends State<ProfileScreenBody>
    with TickerProviderStateMixin {
  bool isVisible = false;

  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileScreenCubit, ProfileScreenStates>(
        builder: (context, state) {
      ProfileScreenCubit profileScreenCubit = ProfileScreenCubit.get(context);
      return SafeArea(
        child: SingleChildScrollView(
            child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10.0.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.0.w),
                child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 500),
                    transitionBuilder:
                        (Widget child, Animation<double> animation) {
                      final offsetAnimation = Tween<Offset>(
                        begin: const Offset(-1.0, 0.0),
                        end: Offset.zero,
                      ).animate(animation);
                      return ClipRect(
                        child: SlideTransition(
                          position: offsetAnimation,
                          child: child,
                        ),
                      );
                    },
                    child: SizedBox(
                      height: 60.h,
                      width: context.width,
                      child: Row(
                        children: [
                          AnimatedSwitcher(
                            duration: const Duration(milliseconds: 500),
                            transitionBuilder:
                                (Widget child, Animation<double> animation) {
                              final offsetAnimation = Tween<Offset>(
                                begin: const Offset(-5.0, 0.0),
                                end: Offset.zero,
                              ).animate(animation);

                              return AnimatedOpacity(
                                opacity: animation.value == 1
                                    ? 1
                                    : (1 - animation.value),
                                duration: const Duration(milliseconds: 100),
                                child: SlideTransition(
                                  position: offsetAnimation,
                                  child: child,
                                ),
                              );
                            },
                            child: isVisible
                                ? SizedBox(
                                    width: context.width * .7,
                                    child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 5.0.h),
                                        child: CustomTextFieldRoundedBorder(
                                          hint: 'Enter Account Number',
                                          textColor: Colors.black,
                                          keyboardType: TextInputType.number,
                                          controller: searchController,
                                          borderColor: Colors.indigo,
                                          hintTextSize: 15.sp,
                                          padding: EdgeInsets.all(7.h),
                                        )),
                                  )
                                : Text(
                                    'Search About Accounts',
                                    style: GoogleFonts.aBeeZee()
                                        .copyWith(fontSize: 15.sp),
                                  ),
                          ),
                          const Spacer(),
                          AnimatedSwitcher(
                            duration: const Duration(milliseconds: 500),
                            transitionBuilder:
                                (Widget child, Animation<double> animation) {
                              final offsetAnimation = Tween<Offset>(
                                begin: const Offset(0, -.5),
                                end: Offset.zero,
                              ).animate(animation);

                              return AnimatedOpacity(
                                opacity: animation.value == 1
                                    ? 1
                                    : (1 - animation.value),
                                duration: const Duration(milliseconds: 100),
                                child: SlideTransition(
                                  position: offsetAnimation,
                                  child: child,
                                ),
                              );
                            },
                            child: isVisible
                                ? IconButton(
                                    key: const ValueKey<int>(0),
                                    onPressed: () {
                                      isVisible = !isVisible;
                                      setState(() {});
                                    },
                                    icon: const FaIcon(FontAwesomeIcons.xmark))
                                : IconButton(
                                    key: const ValueKey<int>(1),
                                    onPressed: () {
                                      isVisible = !isVisible;
                                      setState(() {});
                                    },
                                    icon: const FaIcon(
                                        FontAwesomeIcons.magnifyingGlass)),
                          )
                        ],
                      ),
                    )),
              ),
              SizedBox(
                height: 20.h,
              ),
              Stack(
                children: [
                  GestureDetector(
                    onTap: () {
                      showImageDialog(context,
                          profileScreenCubit.userInfoData?.photoURL ?? '');
                    },
                    child: Hero(
                      tag: 'image',
                      child: ProfileScreenImageWidget(
                        imageUrl: LocatorManager.locator<AppMainScreenCubit>()
                                .userData!
                                .userInfoData
                                .photoURL ??
                            '---',
                      ),
                    ),
                  ),
                  if (widget.id == uId)
                    Positioned(
                      bottom: 5,
                      right: 5,
                      child: CircleAvatar(
                        radius: context.width * .065,
                        backgroundColor: Colors.indigo.withLightness(.7),
                        child: GestureDetector(
                          onTap: () {
                            if (profileScreenCubit.startUploadImage == false) {
                              profileScreenCubit.updateProfileImage(context);
                            }
                          },
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              FaIcon(
                                FontAwesomeIcons.camera,
                                size: 28.h,
                              ),
                              if (profileScreenCubit.startUploadImage)
                                AnimatedContainer(
                                  width: context.width * .12,
                                  height: context.width * .12,
                                  decoration: BoxDecoration(
                                      color: Colors.grey.withOpacity(.7),
                                      borderRadius: BorderRadius.circular(20)),
                                  duration: const Duration(milliseconds: 700),
                                )
                            ],
                          ),
                        ),
                      ),
                    )
                ],
              ),
              SizedBox(
                height: 15.h,
              ),
              if (widget.id == uId)
                AnimatedCrossFade(
                    firstChild: const SizedBox(),
                    secondChild: Padding(
                      padding:
                          EdgeInsets.only(left: 30.w, right: 10.w, top: 10.h),
                      child: SizedBox(
                        height: context.height * .05,
                        child: Row(
                          children: [
                            CustomAnimatedIndicatorProgress(
                                imageUploadProgress:
                                    profileScreenCubit.imageUploadProgress),
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
                    crossFadeState: profileScreenCubit.startUploadImage
                        ? CrossFadeState.showSecond
                        : CrossFadeState.showFirst,
                    duration: const Duration(seconds: 1)),
              SizedBox(
                height: 30.h,
              ),
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
                          profileScreenCubit.userInfoData?.displayName ?? '',
                          maxLines: 5,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.aboreto().copyWith(
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
                          profileScreenCubit.userInfoData?.email ?? '',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.aboreto().copyWith(
                              fontSize: 17.sp, fontWeight: FontWeight.bold),
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
                        profileScreenCubit.userInfoData?.phoneNumber ?? '',
                        style: GoogleFonts.aboreto().copyWith(
                            fontSize: 17.sp, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height: 1.h),
              if (profileScreenCubit.isFollowU)
                Padding(
                  padding: EdgeInsets.only(top: 10.h),
                  child: CustomContainer(
                    text: 'He Follow U',
                    backgroundColor: Colors.cyan.withLightness(.4),
                    topLeftRadius: const Radius.circular(10),
                    bottomRightRadius: const Radius.circular(10),
                  ),
                ),
              if (widget.id != uId)
                ProfileFollowButton(
                  id: widget.id,
                ),
              if (profileScreenCubit.imageUploadProgress == 0)
                SizedBox(
                  height: 15.h,
                ),
              Row(
                children: [
                  Expanded(
                      child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4.w),
                    child: CustomTextButton(
                      text: 'Followers',
                      buttonColor: Colors.cyan,
                      buttonColorLightness: .4,
                      topLeft: 10,
                      topRight: 10,
                      bottomRight: 10,
                      onPressed: () {},
                    ),
                  )),
                  Expanded(
                      child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4.w),
                    child: CustomTextButton(
                      text: 'Following',
                      buttonColor: Colors.cyan,
                      buttonColorLightness: .4,
                      topLeft: 10,
                      bottomRight: 10,
                      bottomLeft: 10,
                      onPressed: () {},
                    ),
                  )),
                ],
              ),
              SizedBox(
                width: context.width,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
                  child: CustomTextButton(
                    text: 'Travels',
                    buttonColor: Colors.cyan,
                    buttonColorLightness: .4,
                    topLeft: 10,
                    topRight: 10,
                    bottomRight: 10,
                    bottomLeft: 10,
                    onPressed: () {},
                  ),
                ),
              ),
              if (widget.id == uId)
                SizedBox(
                  width: context.width,
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
                    child: CustomTextButton(
                      text: 'Edit Your Profile',
                      buttonColor: Colors.grey,
                      buttonColorLightness: .5,
                      topLeft: 10,
                      topRight: 10,
                      bottomRight: 10,
                      bottomLeft: 10,
                      onPressed: () async {
                        profileScreenCubit.userInfoData?.uid = widget.id;

                        await Navigator.push(
                            context,
                            PageRouteBuilder(
                                transitionDuration: const Duration(seconds: 1),
                                settings: RouteSettings(
                                    arguments: profileScreenCubit.userInfoData),
                                pageBuilder: (_, __, ___) =>
                                    const EditProfileScreen()));
                        profileScreenCubit.getUserData(widget.id);
                      },
                    ),
                  ),
                ),
            ],
          ),
        )),
      );
    });
  }
}
