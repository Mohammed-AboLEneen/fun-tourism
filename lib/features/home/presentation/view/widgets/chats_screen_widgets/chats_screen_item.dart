import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fun_adventure/cores/utils/screen_dimentions.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../../cores/utils/images.dart';

class ChatScreenItem extends StatelessWidget {
  const ChatScreenItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: SizedBox(
        height: context.height * .09,
        child: InkWell(
          onTap: () {},
          child: Row(
            children: [
              SizedBox(
                height: context.height * .1,
                width: context.width * .15,
                child: CircleAvatar(
                  backgroundImage: AssetImage(ImagesClass.welcomePngImage),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Mohammed Abo L Eneen Ali',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.abel().copyWith(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(right: 5.0),
                          child: Text('19:02'),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      'There is SomeThing Ridght There',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.abel().copyWith(
                          fontSize: 17.sp,
                          fontWeight: FontWeight.bold,
                          overflow: TextOverflow.ellipsis,
                          color: Colors.black.withOpacity(.5)),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
