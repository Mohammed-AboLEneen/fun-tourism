import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fun_adventure/cores/utils/color_degree.dart';
import 'package:fun_adventure/cores/utils/locator_manger.dart';
import 'package:fun_adventure/cores/utils/screen_dimentions.dart';
import 'package:fun_adventure/features/home/presentation/view_model/main_screen_cubit/main_screen_cubit.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../view_model/main_screen_cubit/main_screen_states.dart';
import '../custom_textbutton.dart';
import 'hot_travel/travel_item.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppMainScreenCubit, AppMainScreenStates>(
        builder: (context, state) {
      return Scaffold(
        backgroundColor: Colors.white.withLightness(.95),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: context.height * .37,
                child: Stack(
                  children: [
                    Container(
                      width: context.width,
                      height: context.height * .32,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          bottomRight: Radius.circular(15),
                          bottomLeft: Radius.circular(15),
                        ),
                        image: DecorationImage(
                          image: NetworkImage(
                            LocatorManager.locator<AppMainScreenCubit>()
                                    .userData
                                    ?.userInfoData
                                    .photoURL ??
                                '',
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          CircleAvatar(
                            radius: context.width * .15,
                            backgroundColor: Colors.white,
                          ),
                          CircleAvatar(
                            radius: context.width * .14,
                            backgroundImage: const NetworkImage(
                                'https://th.bing.com/th/id/R.7ce4ec840984852bd909f623d9ff9a37?rik=rpv7KOZ6uHZU0Q&riu=http%3a%2f%2fimages4.fanpop.com%2fimage%2fphotos%2f22600000%2fNaruto-Shippuden-uzumaki-naruto-22688727-900-650.png&ehk=6bzjgoM1LoUi5WqnLRdLaJb7S7o3cEGrdFtnLWOsc5A%3d&risl=&pid=ImgRaw&r=0'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.0.w),
                      child: CustomTextButton(
                        text: 'Follow',
                        buttonColor: Colors.indigo,
                        topRight: const Radius.circular(20),
                        topLeft: const Radius.circular(20),
                        textSize: 17,
                        onPressed: () {},
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.0.w),
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
              SizedBox(
                height: 20.h,
              ),
              Row(
                children: [
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Row(
                      children: [
                        Text(
                          'Friends : ',
                          style: GoogleFonts.abel().copyWith(
                              fontSize: 20.sp, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '122',
                          style: GoogleFonts.abel().copyWith(
                              fontSize: 15.sp, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  )),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                height: context.height * .15,
                child: ListView.builder(
                  itemBuilder: (context, state) {
                    return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.0.w),
                        child: SizedBox(
                          width: context.width * .2,
                          child: Column(
                            children: [
                              CircleAvatar(
                                radius: context.width * .1,
                                backgroundImage: const NetworkImage(
                                    'https://i.pinimg.com/originals/32/db/ad/32dbadaa9bf670b5258cbebce3ecd240.jpg'),
                              ),
                              Expanded(
                                child: Text(
                                  'Mohammed Abo L Eneen Ali',
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.abel().copyWith(
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.w600),
                                ),
                              )
                            ],
                          ),
                        ));
                  },
                  itemCount: 10,
                  scrollDirection: Axis.horizontal,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Divider(
                  height: 1,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Row(
                      children: [
                        Text(
                          'Travels : ',
                          style: GoogleFonts.abel().copyWith(
                              fontSize: 20.sp, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '9',
                          style: GoogleFonts.abel().copyWith(
                              fontSize: 15.sp, fontWeight: FontWeight.w600),
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
                        hotTravelModel:
                            LocatorManager.locator<AppMainScreenCubit>()
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
      );
    });
  }
}
