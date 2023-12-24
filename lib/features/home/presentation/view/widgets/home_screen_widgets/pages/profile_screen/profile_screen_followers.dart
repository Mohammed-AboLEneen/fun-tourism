import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fun_adventure/cores/utils/screen_dimentions.dart';
import 'package:fun_adventure/features/home/presentation/view/widgets/home_screen_widgets/pages/profile_screen/profile_screen_widgets/profile_followers_screen_item.dart';
import 'package:fun_adventure/features/home/presentation/view_model/follower_screen_cubit/follower_screen_cubit.dart';
import 'package:fun_adventure/features/home/presentation/view_model/follower_screen_cubit/follower_screen_states.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileScreenFollowers extends StatefulWidget {
  final String id;

  const ProfileScreenFollowers({super.key, required this.id});

  @override
  State<ProfileScreenFollowers> createState() => _ProfileScreenFollowersState();
}

class _ProfileScreenFollowersState extends State<ProfileScreenFollowers> {
  int? currentIndex;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FollowerScreenCubit()..getScreenFollowers(widget.id),
      child: BlocConsumer<FollowerScreenCubit, FollowerScreenStates>(
        builder: (context, state) {
          var cubit = FollowerScreenCubit.get(context);

          if (cubit.finishGetFollowers && cubit.followers.isNotEmpty) {
            return Scaffold(
              appBar: AppBar(
                title: Text(
                  'Followers : 10',
                  style: GoogleFonts.aBeeZee(fontSize: 20.sp),
                ),
              ),
              body: SizedBox(
                height: context.height,
                child: ListView.separated(
                    itemBuilder: (context, index) => ProfileFollowersScreenItem(
                          action: () {
                            setState(() {
                              currentIndex = index;
                            });
                          },
                          index: index,
                          currentIndex: currentIndex,
                          followerModel: cubit.followers[index],
                        ),
                    separatorBuilder: (context, index) => Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 30.w,
                          ),
                          child: Container(
                            height: 1,
                            color: Colors.grey,
                          ),
                        ),
                    itemCount: cubit.followers.length),
              ),
            );
          } else if (cubit.finishGetFollowers == false &&
              cubit.followers.isEmpty) {
            return const Scaffold(
              body: Center(
                  child: Padding(
                padding: EdgeInsets.all(20.0),
                child: LinearProgressIndicator(
                  color: Colors.indigo,
                ),
              )),
            );
          } else {
            return Scaffold(
              body: Center(
                child: Padding(
                  padding: EdgeInsets.all(15.0.h),
                  child: Text(
                    'There Is No Followers For This Account',
                    style: GoogleFonts.aBeeZee(fontSize: 25.sp),
                  ),
                ),
              ),
            );
          }
        },
        listener: (context, state) {},
      ),
    );
  }
}
