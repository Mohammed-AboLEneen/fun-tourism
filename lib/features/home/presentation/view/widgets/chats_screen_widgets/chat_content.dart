import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fun_adventure/cores/utils/screen_dimentions.dart';
import 'package:fun_adventure/features/home/presentation/view/widgets/chats_screen_widgets/chat_message.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatContent extends StatefulWidget {
  const ChatContent({super.key});

  @override
  State<ChatContent> createState() => _ChatContentState();
}

class _ChatContentState extends State<ChatContent> {
  @override
  void initState() {
    super.initState();
  }

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
              TextField(
                cursorColor: Colors.blue,
                maxLines: 3,
                minLines: 1,
                decoration: InputDecoration(
                    hintText: 'Send a massage',
                    hintStyle: GoogleFonts.abel().copyWith(color: Colors.grey),
                    suffixIcon: Padding(
                      padding: const EdgeInsets.only(right: 5.0),
                      child: IconButton(
                        onPressed: () {},
                        icon: const FaIcon(FontAwesomeIcons.paperPlane),
                      ),
                    ),
                    focusedBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        borderSide: BorderSide(color: Colors.indigo)),
                    border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        borderSide: BorderSide(color: Colors.indigo))),
              )
            ],
          ),
        ),
      ),
    );
  }
}
