import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fun_adventure/cores/utils/screen_dimentions.dart';
import 'package:fun_adventure/features/home/presentation/view/widgets/chats_screen_widgets/chat_message.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatContent extends StatelessWidget {
  const ChatContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(10.0.h),
          child: Column(
            children: [
              Row(
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.arrow_back_outlined,
                        size: 25.h,
                      )),
                  const SizedBox(
                    width: 10,
                  ),
                  SizedBox(
                    height: context.height * .1,
                    width: context.width * .15,
                    child: const CircleAvatar(
                      child: Icon(Icons.person),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Ahmed Alaa',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.aBeeZee().copyWith(fontSize: 20.sp),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: ListView.builder(
                  itemBuilder: (c, i) {
                    return const ChatMassage(
                      message: 'lolo',
                      bottomLeft: Radius.zero,
                      bottomRight: Radius.circular(20),
                    );
                  },
                  itemCount: 1,
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: const TextField(
                    decoration: InputDecoration(
                        label: Text('Send a message'),
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20)))),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
