
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../generated/locales.g.dart';
import '../../../theme/colors.dart';
import '../../../theme/text_theme.dart';
import '../chats_controller.dart';

 final List<String> tabsChats = [
  LocaleKeys.chat_all.tr,
   LocaleKeys.chat_mention.tr,
   LocaleKeys.chat_unread.tr,
   LocaleKeys.chat_product.tr
];

class ChatTabs extends StatefulWidget {

  const ChatTabs({Key? key}) : super(key: key);

  @override
  State<ChatTabs> createState() => _ChatTabsState();
}

class _ChatTabsState extends State<ChatTabs> {
  late TabController _tabController;
  final ChatsController _controller = Get.find();

  @override
  Widget build(BuildContext context) {
    _tabController = DefaultTabController.of(context)!;

    return TabBar(
      controller: _tabController,
      isScrollable: true,
      tabs: List.generate(
        tabsChats.length,
            (index) => Text(
          tabsChats[index],
          maxLines: 1,
        ),
      ),
      labelColor: GPColor.workPrimary,
      unselectedLabelColor: GPColor.contentSecondary,
      indicatorColor: GPColor.workPrimary,
      indicatorPadding: EdgeInsets.zero,
      labelStyle: textStyle(GPTypography.headingMedium),

      onTap: (visit) async {
        if(visit != _tabController.previousIndex){
          switch(visit){
            case 2:
              _controller.changeTab(newFolders: ["unread"]);
              _controller.initChats();
              break;
            default:
              _controller.changeTab(newFolders: ["default"]);
              _controller.initChats();
          }
        }
      },
    );
  }
}
