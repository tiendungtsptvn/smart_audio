import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../base/widgets/base_smart_refresher_v2.dart';
import '../../../../models/api/chat.dart';
import '../../widgets/empty_chat.dart';
import '../stored_conversation_controller.dart';
import 'dismissible_item.dart';

class StoredConversationBody extends GetView<StoredConversationController> {
  const StoredConversationBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      List<dynamic> chats = [];
      if (controller.storedConversations.isEmpty &&
          controller.isLoading.value) {
        chats = List.generate(10, (index) => ChatModel(loading: true)).toList();
      } else {
        chats = controller.storedConversations;
      }
      return (chats.isEmpty)
          ? const EmptyConversations()
          : BaseSmartFresherV2(
              onRefresh: controller.onReload,
              onLoadMore: controller.onLoadMore,
              child: ListView.builder(
                itemCount: chats.length,
                itemBuilder: (context, index) {
                  return DismissibleStoredConversationItem(
                    chat: chats[index] as ChatModel,
                    index: index,
                  );
                },
              ),
            );
    });
  }
}
