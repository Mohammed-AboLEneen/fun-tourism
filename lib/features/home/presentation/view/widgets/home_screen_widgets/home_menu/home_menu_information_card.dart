import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fun_adventure/constants.dart';
import 'package:fun_adventure/cores/methods/google_sign_out.dart';
import 'package:fun_adventure/cores/methods/toast.dart';
import 'package:fun_adventure/cores/utils/sheard_preferance_helper.dart';
import 'package:fun_adventure/features/authentication/presentation/view/authentcation.dart';
import 'package:fun_adventure/features/home/presentation/view_model/main_screen_cubit/main_screen_cubit.dart';
import 'package:fun_adventure/features/home/presentation/view_model/main_screen_cubit/main_screen_states.dart';

import '../../../../../../../cores/methods/show_alert.dart';
import '../../../../../../../cores/methods/sign_out_firebase.dart';
import '../../../../../../../cores/utils/locator_manger.dart';

class MenuInfoCard extends StatelessWidget {
  const MenuInfoCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppMainScreenCubit, AppMainScreenStates>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: SizedBox(
            height: MediaQuery.of(context).size.height * .1,
            child: Row(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * .5,
                  child: ListTile(
                    title: Text(
                      LocatorManager.locator<AppMainScreenCubit>()
                              .userData
                              ?.userInfoData
                              .displayName ??
                          'Nothing',
                      maxLines: 1,
                      style: TextStyle(
                          fontSize: MediaQuery.of(context).size.height * .025,
                          color: Colors.black.withOpacity(.8),
                          overflow: TextOverflow.ellipsis),
                    ),
                    subtitle: Text(
                      'Manager',
                      maxLines: 1,
                      style: TextStyle(
                          fontSize: MediaQuery.of(context).size.height * .02,
                          color: Colors.black.withOpacity(.5),
                          overflow: TextOverflow.ellipsis),
                    ),
                    leading: CircleAvatar(
                      backgroundImage:
                          LocatorManager.locator<AppMainScreenCubit>()
                                  .userData!
                                  .userInfoData
                                  .photoURL!
                                  .isNotEmpty
                              ? NetworkImage(
                                  LocatorManager.locator<AppMainScreenCubit>()
                                      .userData!
                                      .userInfoData
                                      .photoURL!)
                              : null,
                      child: LocatorManager.locator<AppMainScreenCubit>()
                              .userData!
                              .userInfoData
                              .photoURL!
                              .isEmpty
                          ? const FaIcon(FontAwesomeIcons.user)
                          : null,
                    ),
                    iconColor: Colors.grey,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 0),
                  ),
                ),
                IconButton(
                    onPressed: () {
                      customShowAlert(
                          title: 'Sign Out',
                          content: 'Do you Leave Now ?',
                          noAction: () {},
                          yesAction: () async {
                            try {
                              await signOutUser();
                              await googleSignOut();
                              await SharedPreferenceHelper.prefs.clear();
                              await LocatorManager.locator.reset();
                              await SharedPreferenceHelper.setBool(
                                  key: onBoardingKey, value: true);

                              if (!context.mounted) return;
                              Navigator.pushAndRemoveUntil(context,
                                  PageRouteBuilder(pageBuilder:
                                      (context, animation1, animation2) {
                                return const AuthenticationScreen();
                              }), (route) => false);
                              showToast(
                                  msg: 'Process Success',
                                  toastMessageType:
                                      ToastMessageType.successMessage);
                            } catch (e) {
                              showToast(
                                  msg: 'Process Failed, Try Again',
                                  toastMessageType:
                                      ToastMessageType.failureMessage);
                            }
                          },
                          context: context);
                    },
                    icon: const FaIcon(FontAwesomeIcons.arrowRightFromBracket))
              ],
            ),
          ),
        );
      },
      listener: (BuildContext context, AppMainScreenStates state) {},
    );
  }
}
