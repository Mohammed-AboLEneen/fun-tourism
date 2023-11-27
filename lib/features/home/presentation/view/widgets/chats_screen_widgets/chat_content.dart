import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fun_adventure/cores/utils/screen_dimentions.dart';
import 'package:fun_adventure/features/home/presentation/view/widgets/chats_screen_widgets/chat_content_firestore_helper.dart';
import 'package:fun_adventure/features/home/presentation/view_model/chat_content_cubit/chat_content_cubit.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../../cores/methods/toast.dart';
import 'chat_content_streambuilder.dart';

class ChatContent extends StatefulWidget {
  final String? id;

  const ChatContent({super.key, this.id});

  @override
  State<ChatContent> createState() => _ChatContentState();
}

class _ChatContentState extends State<ChatContent> {
  late Stream<QuerySnapshot> usersStream;
  TextEditingController controller = TextEditingController();
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => ChatContentCubit()..getLocalChat(widget.id ?? ''),
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.only(
                  bottom: 10.0.h, left: 10.0.h, right: 10.0.h, top: 5.0.h),
              child: Column(
                children: [
                  Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            context.pop();
                          },
                          icon: Icon(
                            Icons.arrow_back_outlined,
                            size: 25.h,
                          )),
                      const SizedBox(
                        width: 10,
                      ),
                      SizedBox(
                        height: context.height * .08,
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
                  ChatContentStreamBuilder(
                    scrollController: scrollController,
                    id: widget.id ?? '',
                  ),
                  TextField(
                    cursorColor: Colors.blue,
                    controller: controller,
                    maxLines: 3,
                    minLines: 1,
                    decoration: InputDecoration(
                        hintText: 'Send a massage',
                        hintStyle:
                            GoogleFonts.abel().copyWith(color: Colors.grey),
                        suffixIcon: Padding(
                          padding: const EdgeInsets.only(right: 5.0),
                          child: IconButton(
                            onPressed: () {
                              ChatContentFireStoreHelper.sendNewMessage(
                                      id: widget.id ?? '',
                                      message: controller.text)
                                  .then((value) {
                                print(widget.id);
                                showToast(
                                    msg: 'Done',
                                    toastMessageType:
                                        ToastMessageType.successMessage);

                                scrollController.animateTo(
                                  0,
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeOut,
                                );
                              });
                            },
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
        ));
  }
}
