
import 'package:flutter/material.dart';

import '../../../../models/api/chat.dart';
import '../avatar_chat.dart';
import 'body_chat_item.dart';

class ChatItem extends StatelessWidget {
  const ChatItem({
    Key? key,
    required this.chat,
  }) : super(key: key);
  final ChatModel chat;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          //avatar
          AvatarChat(
            imageUrl: chat.avatar,
            width: 64,
            height: 64,
            isActive: chat.isActive(),
          ),
          //body
          BodyChatItem(chat: chat),
        ],
      ),
    );
  }
}
