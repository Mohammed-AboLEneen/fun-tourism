import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fun_adventure/cores/utils/color_degree.dart';
import 'package:google_fonts/google_fonts.dart';

ExpansionPanel expansionPanelItem(isOpened, String? description) {
  return ExpansionPanel(
    backgroundColor: Colors.white.withLightness(.95),
    headerBuilder: (BuildContext context, bool isExpanded) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          'Tour Information',
          style: GoogleFonts.aBeeZee().copyWith(fontSize: 20.sp),
        ),
      );
    },
    body: Padding(
      padding: const EdgeInsets.only(bottom: 10.0, left: 10.0, right: 10.0),
      child: Text(description ?? '----'),
    ),
    isExpanded: isOpened,
  );
}
