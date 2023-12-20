import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fun_adventure/cores/models/user_data_info/user_info_data.dart';
import 'package:fun_adventure/cores/utils/custom_textfield_rounded_border.dart';
import 'package:fun_adventure/cores/utils/screen_dimentions.dart';
import 'package:fun_adventure/features/home/presentation/view/widgets/custom_textbutton.dart';
import 'package:fun_adventure/features/home/presentation/view/widgets/home_screen_widgets/pages/profile_screen/profile_screen_firestore_manager.dart';
import 'package:fun_adventure/features/home/presentation/view/widgets/home_screen_widgets/pages/profile_screen/profile_screen_widgets/profile_screen_image_widget.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../../../../cores/methods/show_image_dialog.dart';

class EditProfileScreen extends StatefulWidget {
  final String? heroTag;

  const EditProfileScreen({
    super.key,
    this.heroTag,
  });

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  UserInfoData? userInfoData;

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  bool updateProfile = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    storeEditProfileValues();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.0.w),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                SizedBox(
                  height: 50.h,
                ),
                Row(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Hero(
                        tag: widget.heroTag ?? '',
                        child: GestureDetector(
                          onTap: () {
                            showImageDialog(
                                context, userInfoData?.photoURL ?? '');
                          },
                          child: ProfileScreenImageWidget(
                            imageUrl: userInfoData?.photoURL ?? '',
                            whiteCircleRadius: context.width * .23,
                            imageRadius: context.width * .22,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0.w),
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Created in : ',
                                style: GoogleFonts.abhayaLibre()
                                    .copyWith(fontSize: 20.sp),
                              ),
                            ),
                            SizedBox(
                              height: 5.h,
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                '2023-12-15',
                                style: GoogleFonts.abhayaLibre()
                                    .copyWith(fontSize: 20.sp),
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 50.h,
                ),
                CustomTextFieldRoundedBorder(
                  controller: nameController,
                  hint: 'Name',
                  maxLines: 1,
                  topRight: 0,
                  topLeft: 10,
                  bottomRight: 10,
                  bottomLeft: 10,
                  textColor: Colors.black,
                  suffixIcon: Padding(
                    padding: EdgeInsets.all(13.0.h),
                    child: FaIcon(
                      FontAwesomeIcons.file,
                      size: 20.h,
                    ),
                  ),
                  borderColor: Colors.black,
                  padding: EdgeInsets.all(13.h),
                ),
                SizedBox(
                  height: 10.h,
                ),
                CustomTextFieldRoundedBorder(
                  controller: phoneController,
                  hint: 'Phone',
                  maxLines: 1,
                  topRight: 10,
                  topLeft: 10,
                  bottomRight: 10,
                  bottomLeft: 0,
                  keyboardType: TextInputType.phone,
                  textColor: Colors.black,
                  suffixIcon: Padding(
                    padding: EdgeInsets.all(13.0.h),
                    child: FaIcon(
                      FontAwesomeIcons.phoneFlip,
                      size: 20.h,
                    ),
                  ),
                  borderColor: Colors.black,
                  padding: EdgeInsets.all(13.h),
                ),
                SizedBox(
                  height: 10.h,
                ),
                CustomTextFieldRoundedBorder(
                  controller: emailController,
                  hint: 'Email',
                  maxLines: 1,
                  textInputAction: TextInputAction.none,
                  textColor: Colors.black,
                  suffixIcon: Padding(
                    padding: EdgeInsets.all(13.0.h),
                    child: FaIcon(
                      FontAwesomeIcons.google,
                      size: 20.h,
                    ),
                  ),
                  borderColor: Colors.black,
                  topRight: 0,
                  topLeft: 10,
                  bottomRight: 10,
                  bottomLeft: 10,
                  keyboardType: TextInputType.emailAddress,
                  padding: EdgeInsets.all(13.h),
                ),
                SizedBox(
                  height: 30.h,
                ),
                SizedBox(
                  width: context.width * .6,
                  height: 45.h,
                  child: CustomTextButton(
                      text: updateProfile ? '. . .' : 'Save Changes',
                      buttonColor: updateProfile ? Colors.grey : Colors.indigo,
                      buttonColorLightness: .6,
                      topRight: 10,
                      topLeft: 10,
                      bottomLeft: 10,
                      bottomRight: 10,
                      onPressed: () {
                        if (updateProfile == false) {
                          if (formKey.currentState?.validate() ?? false) {
                            setState(() {
                              updateProfile = true;
                              if (kDebugMode) {
                                print(updateProfile);
                              }
                            });
                            ProfileScreenFireStore.updateProfileData(
                                    id: userInfoData?.uid ?? '',
                                    name: nameController.text,
                                    phone: phoneController.text)
                                .then((value) {
                              setState(() {
                                updateProfile = false;
                              });
                            });
                          }
                        }
                      }),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void storeEditProfileValues() {
    userInfoData = ModalRoute.of(context)!.settings.arguments as UserInfoData?;

    nameController.text = userInfoData?.displayName ?? '';
    phoneController.text = userInfoData?.phoneNumber ?? '';
    emailController.text = userInfoData?.email ?? '';
    nameController.text = userInfoData?.displayName ?? '';
  }
}
