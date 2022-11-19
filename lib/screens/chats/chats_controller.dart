import 'dart:async';


import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../base/controller/base_controller.dart';
import '../../base/networking/services/chat_api.dart';
import '../../configs/constants.dart';
import '../../configs/path.dart';
import '../../generated/locales.g.dart';
import '../../models/api/chat.dart';
import '../../routes/router_name.dart';
import '../../theme/colors.dart';
import '../../theme/text_theme.dart';

class ChatsController extends BaseController {
  final ChatAPI _chatAPI = ChatAPI();
  // final AuthAPI _authAPI = AuthAPI();

  RxList chats = [].obs;
  RxString error = "".obs;

  List<ChatModel> _chatsStored = [];
  String _currentKeyword = "";
  Timer? _debounceSearch;
  int _currentPage = 1;
  final String _token =
      'eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCIsImp0aSI6IjEwNDIxNzk1NDAuNzZjY2U4NjVjYmFkNGQwMi4xNjYwMTE0NTkxIn0.eyJpc3MiOiJnYXBvLnZuIiwiYXVkIjoiaW9zLmdhcG8udm4iLCJqdGkiOiIxMDQyMTc5NTQwLjc2Y2NlODY1Y2JhZDRkMDIuMTY2MDExNDU5MSIsImlhdCI6MTY2MDExNDU5MCwibmJmIjoxNjYwMTE0NTkwLCJ1aWQiOjEwNDIxNzk1NDAsIndzaWRzIjoiNTgxODYwNzkxODE2MzE3IiwiZXhwIjoxNjYwMTIxNzkwfQ.S2akoDKpyx8s_iCbwUMkiR8Qlj2flKLZm5ksYocf6HkjEePDZd1VQ2zsCSflQeODYy-y2QaFw6yvzYoKKeoBItT-oYwrWC8xnD1c0jy_4jdkSyrZTBejeh-GY-Q69JvWbJqrgo5P4PnHdnpblTPCkd8sJAa1O3EVLfMMAfmdpvKqFSz0eeNvTY0Ippy4PoZYbIUQiNSm_xsZsbAuhUKKkjcokdzf8mcfNMHs2KFiK6cL1Hi-GwK44aqHmufKYqWwgPzVSMwuxu9AgvcaMABEL6UjCdR9ggcmFn68C7pBznr2wp24xsB8ZuMchYJuL3jg1qYJq8AOJuXR_2siT0EPxQ';
  List<String> _folders = ["default"];

  bool get firstPage => (_currentPage == 1);

  @override
  void onClose() {
    if (_debounceSearch != null) {
      _debounceSearch!.cancel();
    }
    super.onClose();
  }

  @override
  void onInit() async{
    initChats();
    super.onInit();
  }

  void initChats() async {
    chats.value = [];
    isLoading.value = true;
    // await _getThreads();
    await _getChats();
    isLoading.value = false;
  }

  // Future<void> _login() async{
  //   try{
  //     final result = await _authAPI.login();
  //     String? accessToken = result["data"]["access_token"];
  //     if(accessToken != null){
  //       _token = accessToken;
  //     }
  //   }catch(e){
  //     printError(info: e.toString());
  //   }
  // }

  Future<void> _getThreads({bool firstPage = false}) async {
    try {
      int? lastId;
      if (chats.isNotEmpty && !firstPage) {
        lastId = (chats.last as ChatModel).id;
      }
      List<ChatModel> res = await _chatAPI.getThreads(
          token: _token, lastId: lastId, folders: _folders);
      if (_currentKeyword.trim().isNotEmpty) {
        if (firstPage) {
          chats.value = res
              .where(
                  (element) => element.nameContains(keyword: _currentKeyword))
              .toList();
        } else {
          chats.addAll(res
              .where(
                  (element) => element.nameContains(keyword: _currentKeyword))
              .toList());
        }
      }else{
        if (firstPage) {
          chats.value = res;
          _chatsStored = res;
        } else {
          chats.addAll(res);
          _chatsStored.addAll(res);
        }
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

  Future<void> _getChats() async {
    try {
      await Future.delayed(const Duration(seconds: 2));
      List<ChatModel> res = await _chatAPI.getChats(page: _currentPage);
      if (_currentKeyword.trim().isNotEmpty) {
        if (firstPage) {
          chats.value = res
              .where(
                  (element) => element.nameContains(keyword: _currentKeyword))
              .toList();
        } else {
          chats.addAll(res
              .where(
                  (element) => element.nameContains(keyword: _currentKeyword))
              .toList());
        }
      } else {
        if (firstPage) {
          chats.value = res;
          _chatsStored = res;
        } else {
          chats.addAll(res);
          _chatsStored.addAll(res);
        }
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

  void changeTab({required List<String> newFolders}) async {
    _folders = newFolders;
  }

  Future<dynamic> onReload() async {
    await _getThreads(firstPage: true);
  }

  Future<dynamic> onLoadMore() async {
    await _getThreads();
  }

  void onchangeSearch({required String keyword}) {
    if (_debounceSearch?.isActive ?? false) {
      _debounceSearch?.cancel();
    }
    _debounceSearch = Timer(const Duration(milliseconds: 500), () {
      _searchByKeyword(keyword: keyword);
    });
  }

  void _searchByKeyword({required String keyword}) {
    if (keyword.trim().isEmpty) {
      chats.value = _chatsStored;
      return;
    }
    _currentKeyword = keyword;
    List<ChatModel> result = [];
    for (ChatModel chat in _chatsStored) {
      if (chat.nameContains(keyword: keyword)) {
        result.add(chat);
      }
    }
    chats.value = result;
    return;
  }

  void removeChat({required ChatModel chat}) {
    actionCanUndo(
        listItem: chats,
        chat: chat,
        undoMessage: LocaleKeys.chat_delete_success.tr,
        action: () {
          printInfo(info: "Call api remove chat");
        });
  }

  void storeConversation({required ChatModel chat}) {
    Get.back();
    actionCanUndo(
        listItem: chats,
        chat: chat,
        undoMessage: LocaleKeys.chat_store_success.tr,
        action: () {
          printInfo(info: "Call api store conversation");
        });
  }

  void goToStoredConversationScreen() async {
    Get.back();
    bool reloadChats = await Get.toNamed(RouterName.storedConversation);
    if (reloadChats) {
      _currentPage = 1;
      await _getChats();
    }
  }

  static void actionCanUndo({
    required RxList listItem,
    required ChatModel chat,
    required String undoMessage,
    required Function action,
  }) async {
    final storedList = [];
    storedList.addAll(listItem);
    listItem.removeWhere((element) {
      if (element is ChatModel) {
        return chat.id == element.id;
      }
      return false;
    });
    await Get.closeCurrentSnackbar();
    _showSnackBarCanUndo(
        undoMessage: undoMessage,
        listItem: listItem,
        action: action,
        storedList: storedList);
  }

  static void _showSnackBarCanUndo({
    required undoMessage,
    required RxList listItem,
    required Function action,
    required dynamic storedList,
  }) {
    bool acted = false;
    Get.showSnackbar(GetSnackBar(
      backgroundColor: GPColor.bgInversePrimary,
      icon: SvgPicture.asset(AppPaths.iconDone),
      messageText: Text(
        undoMessage,
        style: textStyle(GPTypography.bodyMedium)?.merge(
          const TextStyle(color: GPColor.contentInversePrimary),
        ),
      ),
      duration:  const Duration(seconds: Constants.restoreSnackDuration),
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.symmetric(vertical: 14),
      mainButton: SizedBox(
        width: 98,
        child: Row(
          children: [
            Container(
              width: 1,
              height: 20,
              color: GPColor.functionAlwaysLightPrimary.withOpacity(0.3),
            ),
            const Spacer(),
            InkWell(
              onTap: () {
                acted = true;
                Get.closeCurrentSnackbar();
                listItem.value = storedList;
              },
              child: Text(
                LocaleKeys.chat_undo.tr,
                style: textStyle(GPTypography.headingSmall)?.merge(
                  const TextStyle(color: GPColor.functionAccentWorkSecondary),
                ),
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
      borderRadius: 8,
      snackPosition: SnackPosition.TOP,
    )).future.then((value) {
      if (!acted) {
        action();
      }
    });
  }
}
