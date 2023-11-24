import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fun_adventure/cores/methods/toast.dart';
import 'package:fun_adventure/cores/utils/screen_dimentions.dart';
import 'package:fun_adventure/features/home/presentation/view/widgets/chats_screen_widgets/chat_message.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../../constants.dart';

class ChatContent extends StatefulWidget {
  final String? id;

  const ChatContent({super.key, this.id});

  @override
  State<ChatContent> createState() => _ChatContentState();
}

class _ChatContentState extends State<ChatContent> {
  late Stream<QuerySnapshot> usersStream;
  TextEditingController controller = TextEditingController();
  final GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();
  ScrollController scrollController = ScrollController();
  List<String> messages = [];

  void addItem() {
    int newIndex = messages.length;
    messages.add(controller.text);
    listKey.currentState?.insertItem(newIndex - 1);
  }

  @override
  void initState() {
    super.initState();

    usersStream = FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .collection('chats')
        .doc(widget.id)
        .collection('newMessages')
        .orderBy('time')
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              StreamBuilder(
                  stream: usersStream,
                  builder: (context, snap) {
                    if (snap.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: Colors.indigo,
                        ),
                      );
                    } else {
                      messages.clear();
                      for (var doc in snap.data!.docs) {
                        Map<String, dynamic> data =
                        doc.data()! as Map<String, dynamic>;

                        messages.add(data['message']);
                      }

                      print(messages.length);
                      return Expanded(
                        child: AnimatedList(
                          controller: scrollController,
                          key: listKey,
                          initialItemCount: messages.length,
                          itemBuilder: (context, index, animation) {
                            return SizeTransition(
                                sizeFactor: animation,
                                child: Padding(
                                  padding:
                                  EdgeInsets.symmetric(vertical: 8.0.h),
                                  child: ChatMassage(
                                    message: messages[index],
                                    bottomLeft: Radius.zero,
                                    bottomRight: const Radius.circular(20),
                                  ),
                                ));
                          },
                        ),
                      );
                    }
                  }),
              TextField(
                cursorColor: Colors.blue,
                controller: controller,
                maxLines: 3,
                minLines: 1,
                decoration: InputDecoration(
                    hintText: 'Send a massage',
                    hintStyle: GoogleFonts.abel().copyWith(color: Colors.grey),
                    suffixIcon: Padding(
                      padding: const EdgeInsets.only(right: 5.0),
                      child: IconButton(
                        onPressed: () {
                          FirebaseFirestore.instance
                              .collection('users')
                              .doc(uId)
                              .collection('chats')
                              .doc(widget.id)
                              .collection('newMessages')
                              .add({
                            'message': controller.text,
                            'time': DateTime.now(),
                            'receiverId': widget.id,
                            'senderId': uId
                          }).then((value) {
                            showToast(
                                msg: 'Done',
                                toastMessageType:
                                ToastMessageType.successMessage);

                            addItem();
                            scrollController.animateTo(
                              scrollController.position.maxScrollExtent,
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
    );
  }
}
