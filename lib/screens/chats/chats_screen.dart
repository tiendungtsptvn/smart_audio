
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_audio/screens/chats/widgets/chats_body.dart';
import 'package:smart_audio/screens/chats/widgets/header.dart';
import 'package:smart_audio/screens/chats/widgets/search.dart';

import 'chats_controller.dart';

class ChatsScreenBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => ChatsController());
  }
}

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ChatsController chatsController = Get.put(ChatsController());
    return GestureDetector(
      onTap: (){
        FocusScope.of(context).unfocus();
      },
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: const [
              HeaderChats(),
              SizedBox(height: 20,),
              SearchChats(),
              SizedBox(height: 5,),
              ChatsBody()
            ],
          ),
        ),
      ),
    );
  }
}

