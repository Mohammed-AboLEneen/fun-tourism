import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../cores/models/message_content_model/message_content_model.dart';
import 'chat_message.dart';

class AnimatedChatMessagesList extends StatelessWidget {
  final ScrollController scrollController;
  final List<MessageContentModel> messages;
  final GlobalKey<AnimatedListState> listKey;

  const AnimatedChatMessagesList(
      {super.key,
      required this.scrollController,
      required this.messages,
      required this.listKey});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: AnimatedList(
        controller: scrollController,
        initialItemCount: messages.length,
        key: listKey,
        reverse: true,
        itemBuilder: (context, index, animation) {
          return SizeTransition(
              sizeFactor: animation,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0.h),
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
}
