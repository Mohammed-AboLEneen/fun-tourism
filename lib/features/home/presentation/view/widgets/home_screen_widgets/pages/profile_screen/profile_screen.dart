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
  final bool? isThisYourAccount;

  const ProfileScreen({
    super.key,
    this.isThisYourAccount,
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
    print('l;dspsodsfs;cmmcx');
    print(id);
    if (id?.isEmpty ?? false) id = uId;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileScreenCubit()..profileCubitOperations(id!),
      child: BlocConsumer<ProfileScreenCubit, ProfileScreenStates>(
          builder: (context, state) {
            ProfileScreenCubit profileScreenCubit =
                ProfileScreenCubit.get(context);

            if ((profileScreenCubit.userInfoData?.displayName?.isNotEmpty ??
                    false) ||
                (profileScreenCubit.userInfoData?.photoURL?.isNotEmpty ??
                    false)) {
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
                        body: ProfileScreenBody(
                          id: id!,
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
                child: CircularProgressIndicator(
                  color: Colors.indigo,
                ),
              );
            }
          },
          listener: (context, state) {}),
    );
  }
}
