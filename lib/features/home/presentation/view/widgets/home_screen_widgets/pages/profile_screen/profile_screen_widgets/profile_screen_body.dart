import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fun_adventure/cores/utils/color_degree.dart';
import 'package:fun_adventure/cores/utils/screen_dimentions.dart';
import 'package:fun_adventure/features/home/presentation/view/widgets/custom_textbutton.dart';
import 'package:fun_adventure/features/home/presentation/view/widgets/home_screen_widgets/pages/profile_screen/edit_screen.dart';
import 'package:fun_adventure/features/home/presentation/view/widgets/home_screen_widgets/pages/profile_screen/profile_screen_widgets/custom_animated_indicator_progress.dart';
import 'package:fun_adventure/features/home/presentation/view/widgets/home_screen_widgets/pages/profile_screen/profile_screen_widgets/profile_screen_image_widget.dart';
import 'package:fun_adventure/features/home/presentation/view/widgets/home_screen_widgets/pages/profile_screen/profile_screen_widgets/profile_screen_user_info.dart';
import 'package:fun_adventure/features/home/presentation/view/widgets/home_screen_widgets/pages/profile_screen/profile_screen_widgets/profile_search_bar.dart';
import 'package:fun_adventure/features/home/presentation/view_model/profile_cubit/profile_cubit.dart';
import 'package:fun_adventure/features/home/presentation/view_model/profile_cubit/profile_states.dart';

import '../../../../../../../../../constants.dart';
import '../../../../../../../../../cores/methods/show_image_dialog.dart';
import '../../../../../../../../../cores/utils/custom_container.dart';
import '../profile_screen_followers.dart';
import 'follow_button.dart';

class ProfileScreenBody extends StatefulWidget {
  final String? heroAnimationProfileImageTag;
  final String id;

  const ProfileScreenBody(
      {super.key, required this.id, this.heroAnimationProfileImageTag});

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
                child: const ProfileScreenSearchBar(),
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
                    child: widget.heroAnimationProfileImageTag != null
                        ? Hero(
                            tag: widget.heroAnimationProfileImageTag ?? '',
                            child: ProfileScreenImageWidget(
                              imageUrl:
                                  profileScreenCubit.userInfoData?.photoURL ??
                                      '---',
                            ),
                          )
                        : ProfileScreenImageWidget(
                            imageUrl:
                                profileScreenCubit.userInfoData?.photoURL ??
                                    '---',
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
              if (profileScreenCubit.isFollowU)
                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: EdgeInsets.only(top: 5.h, right: 20.w),
                    child: CustomContainer(
                      text: 'He Follow U',
                      backgroundColor: Colors.cyan.withLightness(.4),
                      topLeftRadius: const Radius.circular(10),
                      bottomRightRadius: const Radius.circular(10),
                    ),
                  ),
                ),
              if (widget.id != uId)
                ProfileFollowButton(
                  id: widget.id,
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
              ProfileScreenUserInformation(
                userInfoData: profileScreenCubit.userInfoData,
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
                      onPressed: () {
                        Navigator.push(
                            context,
                            PageRouteBuilder(
                                pageBuilder:
                                    (context, animation1, animation2) =>
                                        const ProfileScreenFollowers(),
                                transitionsBuilder:
                                    (context, animation1, animation2, child) {
                                  return SlideTransition(
                                    position: Tween<Offset>(
                                            begin: Offset(-1, 0),
                                            end: Offset.zero)
                                        .animate(animation1),
                                    child: ProfileScreenFollowers(),
                                  );
                                }));
                      },
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
                                reverseTransitionDuration:
                                    const Duration(milliseconds: 700),
                                settings: RouteSettings(
                                    arguments: profileScreenCubit.userInfoData),
                                pageBuilder: (_, __, ___) => EditProfileScreen(
                                      heroTag:
                                          widget.heroAnimationProfileImageTag,
                                    )));
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
