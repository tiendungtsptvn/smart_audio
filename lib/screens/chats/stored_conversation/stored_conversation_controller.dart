
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../base/controller/base_controller.dart';
import '../../../base/networking/services/chat_api.dart';
import '../../../generated/locales.g.dart';
import '../../../models/api/chat.dart';
import '../../../theme/colors.dart';
import '../../../theme/text_theme.dart';
import '../chats_controller.dart';

class StoredConversationController extends BaseController {
  final ChatAPI _chatAPI = ChatAPI();

  RxList storedConversations = [].obs;
  RxString error = "".obs;

  int _currentPage = 1;
  bool _reloadPreviousScreen = false;
  bool get firstPage => (_currentPage == 1);

  @override
  void onInit() {
    initChats();
    super.onInit();
  }

  void initChats() async {
    isLoading.value = true;
    await _getChats();
    isLoading.value = false;
  }

  Future<void> _getChats() async {
    try {
      await Future.delayed(const Duration(seconds: 2));
      List<ChatModel> res =
          await _chatAPI.getStoredConversations(page: _currentPage);
      if (firstPage) {
        storedConversations.value = res;
      } else {
        storedConversations.addAll(res);
      }
    } catch (e) {
      Get.showSnackbar(GetSnackBar(
        backgroundColor: GPColor.workPrimary,
        messageText: Text(
          LocaleKeys.chat_errorNotification.tr,
          style: textStyle(GPTypography.bodyMedium)
              ?.merge(const TextStyle(color: GPColor.contentInversePrimary)),
        ),
        duration: const Duration(seconds: 2),
      ));
    }
  }

  Future<dynamic> onReload() async {
    _currentPage = 1;
    await _getChats();
  }

  Future<dynamic> onLoadMore() async {
    _currentPage += 1;
    await _getChats();
  }

  void removeStoredConversation({required ChatModel chat}) {
    ChatsController.actionCanUndo(
        listItem: storedConversations,
        chat: chat,
        undoMessage: LocaleKeys.chat_delete_success.tr,
        action: () {
          printInfo(info: "Call api remove stored conversation");
        });
  }

  void restoreStoredConversation({required ChatModel chat}) {
    ChatsController.actionCanUndo(
        listItem: storedConversations,
        chat: chat,
        undoMessage: LocaleKeys.chat_restore_success.tr,
        action: () {
          _reloadPreviousScreen = true;
          printInfo(info: "Call api restore stored conversation");
        });
  }

  void backToPreviousScreen() {
    Get.back(result: _reloadPreviousScreen);
  }
}
