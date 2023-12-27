import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fun_adventure/cores/utils/color_degree.dart';
import 'package:fun_adventure/features/home/presentation/view/widgets/home_screen_widgets/pages/profile_screen/profile_screen_widgets/profile_screen_body.dart';
import 'package:fun_adventure/features/home/presentation/view_model/profile_cubit/profile_cubit.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../../../../constants.dart';
import '../../../../../view_model/profile_cubit/profile_states.dart';

class ProfileScreen extends StatefulWidget {
  final bool showLoadingIndicator;
  final String? heroTag;

  const ProfileScreen({
    super.key,
    required this.showLoadingIndicator,
    this.heroTag,
  });

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String? id = '';

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    id = ModalRoute.of(context)!.settings.arguments as String?;
    if (id == null || (id?.isEmpty ?? false)) id = uId;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileScreenCubit()..profileCubitOperations(id!),
      child: BlocBuilder<ProfileScreenCubit, ProfileScreenStates>(
        builder: (context, state) {
          ProfileScreenCubit profileScreenCubit =
              ProfileScreenCubit.get(context);

          if (profileScreenCubit.userInfoData != null) {
            return TweenAnimationBuilder(
                tween: Tween<double>(begin: 0, end: 1),
                duration: const Duration(seconds: 1),
                builder: (_, value, __) {
                  return Opacity(
                    opacity: value,
                    child: Scaffold(
                      backgroundColor: Colors.white.withLightness(.95),
                      body: ProfileScreenBody(
                        id: id!,
                        heroAnimationProfileImageTag: widget.heroTag,
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
            return Scaffold(
              backgroundColor: Colors.white,
              body: Center(
                child: SizedBox(
                  width: 70.w,
                  child: const LinearProgressIndicator(
                    color: Colors.indigo,
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
