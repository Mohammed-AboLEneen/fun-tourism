import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fun_adventure/cores/utils/screen_dimentions.dart';
import 'package:fun_adventure/features/home/presentation/view/widgets/home_screen_widgets/pages/profile_screen/profile_screen_widgets/profile_followers_screen_item.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileScreenFollowers extends StatefulWidget {
  const ProfileScreenFollowers({super.key});

  @override
  State<ProfileScreenFollowers> createState() => _ProfileScreenFollowersState();
}

class _ProfileScreenFollowersState extends State<ProfileScreenFollowers> {
  int? currentIndex;

  @override
  Widget build(BuildContext context) {
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
            itemCount: 10),
      ),
    );
  }
}
