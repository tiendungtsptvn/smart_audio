
import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_audio/constants/constants.dart';
import 'package:smart_audio/screens/home/home_controller.dart';
import 'package:smart_audio/screens/player/player_controller.dart';
import 'package:smart_audio/screens/splash/splash_screen.dart';
import 'package:smart_audio/screens/tabs/tabs_controller.dart';
import 'package:smart_audio/theme/colors.dart';

import '../auth/auth_controller.dart';

class TabsScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AuthController());
    Get.lazyPut(() => TabsController());
    Get.lazyPut(() => HomeController());
  }
}

class TabsScreen extends GetView<AuthController>{
  const TabsScreen({
    Key? key,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        if (controller.initializing) {
          return const SplashScreen();
        } else {
          TabsController tabsController = Get.find<TabsController>();
          Get.find<PlayerController>().createSpotifyApi(
            controller.isAnonymous,
            accessToken: controller.accessToken,
          );
          print("isAnonymous: ${controller.isAnonymous}");
          print("access token: ${controller.accessToken}");
          return Obx(() => Scaffold(
                body: SafeArea(
                  child: Stack(
                    children: [
                      tabsApp.elementAt(tabsController.currentIndex),
                      // const Align(
                      //   alignment: Alignment.bottomCenter,
                      //   child: MiniPlayerScreen(),
                      // )
                    ],
                  ),
                ),
                bottomNavigationBar: BottomBarDefault(
                  items: const [
                    TabItem(
                      icon: Icons.home,
                      title: "Home",
                    ),
                    TabItem(
                      icon: Icons.chat_bubble,
                      title: "Chat",
                    ),
                    TabItem(
                      icon: Icons.settings,
                      title: "Me",
                    ),
                  ],
                  backgroundColor: Colors.grey.withOpacity(0.2),
                  color: Colors.black,
                  colorSelected: GPColor.workPrimary,
                  animated: false,
                  indexSelected: tabsController.currentIndex,
                  iconSize: 24,
                  top: 10,
                  bottom: 10,
                  titleStyle: const TextStyle(fontSize: 11, fontWeight: FontWeight.w500),
                  boxShadow: tabBarShadow,
                  onTap: (newIndex) {
                    tabsController.changeTab(newIndex);
                  },
                ),
              ));
        }
      },
    );
  }
}
