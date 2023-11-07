import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fun_adventure/cores/utils/color_degree.dart';
import 'package:fun_adventure/cores/utils/screen_dimentions.dart';
import 'package:google_fonts/google_fonts.dart';

class HotTravelScreenCreatorPart extends StatelessWidget {
  final String? creator;

  const HotTravelScreenCreatorPart({super.key, required this.creator});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: context.width,
        height: context.height * .1,
        decoration: BoxDecoration(
          color: Colors.white.withLightness(.93),
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        padding: const EdgeInsets.only(right: 5.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  creator ?? '-----',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.akayaKanadaka()
                      .copyWith(fontSize: 17.sp, fontWeight: FontWeight.w400),
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            SizedBox(
              height: context.height * .1,
              width: context.width * .16,
              child: const CircleAvatar(
                child: FaIcon(FontAwesomeIcons.person),
              ),
            )
          ],
        ));
  }
}
