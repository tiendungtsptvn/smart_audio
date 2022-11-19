
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../base/widgets/base_smart_refresher_v2.dart';
import '../../../models/api/chat.dart';
import '../chats_controller.dart';
import 'chat_item/dismissible_chat_item.dart';
import 'chat_tabs.dart';
import 'empty_chat.dart';

class ChatsBody extends GetView<ChatsController> {
  const ChatsBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabsChats.length,
      initialIndex: 0,
      child: Builder(
        builder: (BuildContext context) {
          return Flexible(
            child: Column(
              children: [
                 const SizedBox(
                  height: 50,
                  child: ChatTabs(),
                ),
                Flexible(
                    child: TabBarView(
                  physics: const NeverScrollableScrollPhysics(),
                  children: List.generate(tabsChats.length, (index) {
                    return Obx(() {
                      List<dynamic> chats = [];
                      if (controller.chats.isEmpty &&
                          controller.isLoading.value) {
                        chats = List.generate(
                            10, (index) => ChatModel(loading: true)).toList();
                      } else {
                        chats = controller.chats;
                      }
                      return (chats.isEmpty)
                          ? const EmptyConversations()
                          : BaseSmartFresherV2(
                              onRefresh: controller.onReload,
                              onLoadMore: controller.onLoadMore,
                              child: ListView.builder(
                                itemCount: chats.length,
                                itemBuilder: (context, index) {
                                  return DismissibleChatItem(
                                    chat: chats[index] as ChatModel,
                                    index: index,
                                  );
                                },
                              ),
                            );
                    });
                  }),
                ))
              ],
            ),
          );
        },
      ),
    );
  }
}
