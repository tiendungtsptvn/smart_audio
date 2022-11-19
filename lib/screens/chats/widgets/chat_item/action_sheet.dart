
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../generated/locales.g.dart';
import '../../../../models/api/chat.dart';
import '../../chats_controller.dart';

class ActionSheetMore extends GetView<ChatsController> {
  const ActionSheetMore({Key? key, required this.chat}) : super(key: key);
  final ChatModel chat;
  @override
  Widget build(BuildContext context) {
    return CupertinoActionSheet(
      title: Text(LocaleKeys.chat_pick_function.tr),
      actions: [
        CupertinoActionSheetAction(
          isDefaultAction: true,
          onPressed: () async {},
          child: Text(LocaleKeys.chat_block_message.tr),
        ),
        CupertinoActionSheetAction(
          isDefaultAction: true,
          onPressed: () async {},
          child: Text(LocaleKeys.chat_pin.tr),
        ),
        CupertinoActionSheetAction(
          isDefaultAction: true,
          onPressed: () async {},
          child: Text(LocaleKeys.chat_turn_off_notification.tr),
        ),
        CupertinoActionSheetAction(
          isDefaultAction: true,
          onPressed: () async {},
          child: Text(LocaleKeys.chat_turn_on_secret_conversation.tr),
        ),
        CupertinoActionSheetAction(
          isDefaultAction: true,
          onPressed: () async {
            controller.storeConversation(chat: chat);
          },
          child: Text(LocaleKeys.chat_store_conversation.tr),
        ),
        CupertinoActionSheetAction(
          isDestructiveAction: true,
          onPressed: () async {},
          child: Text(LocaleKeys.chat_delete_conversation.tr),
        )
      ],
      cancelButton: CupertinoActionSheetAction(
        child: Text(LocaleKeys.chat_cancel.tr),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
