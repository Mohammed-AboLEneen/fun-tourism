import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fun_adventure/cores/utils/custom_textfield_rounded_border.dart';
import 'package:fun_adventure/cores/utils/screen_dimentions.dart';
import 'package:fun_adventure/features/home/presentation/view/widgets/custom_textbutton.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../../../../../constants.dart';
import '../../../../../../../../../cores/methods/toast.dart';
import '../profile_screen.dart';

class ProfileScreenSearchBar extends StatefulWidget {
  const ProfileScreenSearchBar({
    super.key,
  });

  @override
  State<ProfileScreenSearchBar> createState() => _ProfileScreenSearchBarState();
}

class _ProfileScreenSearchBarState extends State<ProfileScreenSearchBar> {
  TextEditingController searchController = TextEditingController();
  bool isVisible = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60.h,
      width: context.width,
      child: Row(
        children: [
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 500),
            transitionBuilder: (Widget child, Animation<double> animation) {
              final offsetAnimation = Tween<Offset>(
                begin: const Offset(-5.0, 0.0),
                end: Offset.zero,
              ).animate(animation);

              return AnimatedOpacity(
                opacity: animation.value == 1 ? 1 : (1 - animation.value),
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
                        padding: EdgeInsets.symmetric(vertical: 5.0.h),
                        child: CustomTextFieldRoundedBorder(
                          hint: 'Enter Account Number',
                          textColor: Colors.black,
                          suffixIcon: CustomTextButton(
                            text: 'search',
                            textColorLightness: 0,
                            textColor: Colors.black,
                            buttonColor: Colors.indigo,
                            topRight: 10,
                            bottomRight: 10,
                            onPressed: () {
                              if (searchController.text.isNotEmpty) {
                                accountsSearchMethod();
                              }
                            },
                          ),
                          keyboardType: TextInputType.number,
                          controller: searchController,
                          borderColor: Colors.indigo,
                          hintTextSize: 15.sp,
                          padding: EdgeInsets.all(7.h),
                        )),
                  )
                : Text(
                    'Search About Accounts',
                    style: GoogleFonts.aBeeZee().copyWith(fontSize: 15.sp),
                  ),
          ),
          const Spacer(),
          isVisible
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
                  icon: const FaIcon(FontAwesomeIcons.magnifyingGlass)),
        ],
      ),
    );
  }

  Future<void> accountsSearchMethod() async {
    try {
      QuerySnapshot<Map<String, dynamic>> data = await FirebaseFirestore
          .instance
          .collection('users')
          .where('countNumber', isEqualTo: searchController.text)
          .get();

      if (data.docs.isEmpty) {
        showToast(
            msg: 'This Account Dosen\'t Exist',
            toastMessageType: ToastMessageType.failureMessage);
      } else {
        if (data.docs.first.id == uId) {
          showToast(
              msg: 'This Is Your Account Number',
              toastMessageType: ToastMessageType.successMessage);
        } else {
          if (!context.mounted) return;
          Navigator.push(
            context,
            PageRouteBuilder(
                transitionDuration: const Duration(milliseconds: 500),
                reverseTransitionDuration: const Duration(milliseconds: 500),
                pageBuilder: (context, animation, secondaryAnimation) =>
                    const ProfileScreen(
                      heroTag: 'image',
                    ),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  var begin = const Offset(0.0, 1.0);
                  var end = Offset.zero;
                  var tween = Tween(begin: begin, end: end);
                  var offsetAnimation = animation.drive(tween);

                  return SlideTransition(
                    position: offsetAnimation,
                    child: child,
                  );
                },
                settings: RouteSettings(arguments: data.docs.first.id)),
          );
        }
      }
    } catch (e) {
      showToast(
          msg: 'SomeThing Is Wrong, Try Again',
          toastMessageType: ToastMessageType.failureMessage);
    }
  }
}
