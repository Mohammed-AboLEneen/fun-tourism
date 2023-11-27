import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fun_adventure/features/home/presentation/view_model/chat_content_cubit/chat_content_cubit.dart';
import 'package:fun_adventure/features/home/presentation/view_model/chat_content_cubit/chat_content_states.dart';

import '../../../../../../constants.dart';
import '../../../../../../cores/methods/delete_coolection.dart';
import 'chat_message.dart';

class ChatContentStreamBuilder extends StatefulWidget {
  final ScrollController scrollController;
  final String id;

  const ChatContentStreamBuilder({
    super.key,
    required this.scrollController,
    required this.id,
  });

  @override
  State<ChatContentStreamBuilder> createState() =>
      _ChatContentStreamBuilderState();
}

class _ChatContentStreamBuilderState extends State<ChatContentStreamBuilder> {
  late Stream<QuerySnapshot> usersStream;

  @override
  void initState() {
    super.initState();
    usersStream = FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .collection('chats')
        .doc(widget.id)
        .collection('newMessages')
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: usersStream,
        builder: (context, snap) {
          print('dsd');
          if (snap.hasData) {
            if (snap.data?.docs.isNotEmpty ?? false) {
              BlocProvider.of<ChatContentCubit>(context)
                  .saveTheNewChatMessagesFromFireStore(snap.data!.docs)
                  .then((value) {
                deleteFireStoreCollection(FirebaseFirestore.instance
                    .collection('users')
                    .doc(uId)
                    .collection('chats')
                    .doc(BlocProvider.of<ChatContentCubit>(context).receiverId)
                    .collection('newMessages'));
              });
            }
          }

          return BlocBuilder<ChatContentCubit, ChatContentStates>(
            builder: (context, state) {
              ChatContentCubit cubit = ChatContentCubit.get(context);
              return Expanded(
                child: ListView.builder(
                  controller: widget.scrollController,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0.h),
                      child: ChatMassage(
                        message: cubit.messages[index],
                        bottomLeft: Radius.zero,
                        bottomRight: const Radius.circular(20),
                      ),
                    );
                  },
                  itemCount: cubit.messages.length,
                ),
              );
            },
          );
        });
  }
}
