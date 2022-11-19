
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';

import '../../../../configs/path.dart';
import '../../../../generated/locales.g.dart';
import '../../../../models/api/chat.dart';
import '../../../../theme/colors.dart';
import '../../widgets/chat_item/chat_item.dart';
import '../../widgets/chat_item/chat_item_loading.dart';
import '../../widgets/chat_item/dismissible_action.dart';
import '../stored_conversation_controller.dart';

class DismissibleStoredConversationItem
    extends GetView<StoredConversationController> {
  const DismissibleStoredConversationItem({
    Key? key,
    required this.chat,
    required this.index,
  }) : super(key: key);
  final ChatModel chat;
  final int index;

  @override
  Widget build(BuildContext context) {
    if (chat.isLoading()) {
      return const ChatItemLoading();
    }
    return Slidable(
      key: Key((chat.id ?? "").toString()),
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        extentRatio: 0.45,
        children: [
          const SizedBox(
            width: 12,
          ),
          DismissibleAction(
            onTap: () {
              controller.restoreStoredConversation(chat: chat);
            },
            backgroundColor: GPColor.bgTertiary,
            iconPath: AppPaths.iconRestore,
            iconColor: GPColor.contentPrimary,
            text: LocaleKeys.chat_restore.tr,
            textColor: GPColor.contentPrimary,
            flex: 1,
          ),
          DismissibleAction(
            onTap: () {
              controller.removeStoredConversation(chat: chat);
            },
            backgroundColor: GPColor.functionNegativePrimary,
            iconPath: AppPaths.iconRecycleBin,
            iconColor: GPColor.contentInversePrimary,
            text: LocaleKeys.chat_delete.tr,
            textColor: GPColor.contentInversePrimary,
            flex: 1,
          ),
        ],
      ),
      child: ChatItem(chat: chat),
    );
  }
}
