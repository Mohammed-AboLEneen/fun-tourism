import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'chats_screen_item.dart';

class ChatScreenWidget extends StatelessWidget {
  const ChatScreenWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(.8),
      appBar: AppBar(
        title: Text(
          'chats',
          style: GoogleFonts.aBeeZee().copyWith(fontSize: 25.sp),
        ),
        actions: const [],
        centerTitle: true,
      ),
      body: const SingleChildScrollView(
        child: Column(
          children: [
            ChatScreenItem(),
            ChatScreenItem(),
            ChatScreenItem(),
            ChatScreenItem(),
            ChatScreenItem(),
            ChatScreenItem(),
          ],
        ),
      ),
    );
  }
}
