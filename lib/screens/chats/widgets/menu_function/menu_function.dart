
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../configs/path.dart';
import '../../../../generated/locales.g.dart';
import '../../../../theme/colors.dart';
import '../../chats_controller.dart';
import 'header.dart';
import 'item_menu_function.dart';

class MenuFunction extends GetView<ChatsController> {
  const MenuFunction({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const HeaderMenuFunction(),
        const Divider(
          height: 1,
          color: GPColor.linePrimary,
        ),
        const SizedBox(
          height: 8,
        ),
        ItemMenuFunction(
          text: LocaleKeys.chat_waiting_message.tr,
          iconPath: AppPaths.iconWaitingMessage,
          showCountInfo: true,
        ),
        ItemMenuFunction(
          text: LocaleKeys.chat_stored_message.tr,
          iconPath: AppPaths.iconStoredMessage,
          onTap: () {
            controller.goToStoredConversationScreen();
          },
        ),
      ],
    );
  }
}
