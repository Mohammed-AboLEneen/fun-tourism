import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fun_adventure/cores/utils/color_degree.dart';
import 'package:fun_adventure/cores/utils/screen_dimentions.dart';
import 'package:google_fonts/google_fonts.dart';

class HotTravelScreenInfo extends StatelessWidget {
  final String? price;
  final String? time;
  final String? rate;

  const HotTravelScreenInfo({super.key, this.price, this.time, this.rate});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width * .9,
      height: (context.width * .5),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                'Sightseeing Tours',
                style: GoogleFonts.abel().copyWith(
                    fontSize: 14.sp, color: Colors.white.withLightness(.45)),
              ),
              const SizedBox(
                height: 5,
              ),
              Text('Super Safari VIP',
                  style: GoogleFonts.abel().copyWith(
                    fontSize: 23.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  )),
              const SizedBox(
                height: 5,
              ),
              Text(price ?? '---',
                  style: GoogleFonts.abel().copyWith(
                    fontSize: 18.sp,
                    color: Colors.white.withLightness(.3),
                  )),
              const SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  Text(time ?? '---',
                      style: GoogleFonts.abel().copyWith(
                        fontSize: 15.sp,
                        color: Colors.white.withLightness(.2),
                      )),
                  const Spacer(),
                  Text('Duration',
                      style: GoogleFonts.abel().copyWith(
                        fontSize: 15.sp,
                        color: Colors.white.withLightness(.2),
                      )),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Row(
                    children: [
                      Text(rate ?? '---',
                          style: GoogleFonts.abel().copyWith(
                            fontSize: 15.sp,
                            color: Colors.white.withLightness(.2),
                          )),
                      FaIcon(
                        FontAwesomeIcons.solidStar,
                        size: 15.h,
                        color: Colors.yellow.withLightness(.498),
                      )
                    ],
                  ),
                  const Spacer(),
                  Text('Rating',
                      style: GoogleFonts.abel().copyWith(
                        fontSize: 15.sp,
                        color: Colors.white.withLightness(.2),
                      )),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
