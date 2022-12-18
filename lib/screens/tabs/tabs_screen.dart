import 'package:alan_voice/alan_voice.dart';
import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_audio/constants/constants.dart';
import 'package:smart_audio/screens/home/home_controller.dart';
import 'package:smart_audio/screens/player/player_controller.dart';
import 'package:smart_audio/screens/search/search_controller.dart';
import 'package:smart_audio/screens/splash/splash_screen.dart';
import 'package:smart_audio/screens/tabs/tabs_controller.dart';
import 'package:smart_audio/screens/wishlist_tracks/wishlist_controller.dart';
import 'package:smart_audio/theme/colors.dart';

import '../alan/alan_controller.dart';
import '../auth/auth_controller.dart';

class TabsScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AuthController());
    Get.lazyPut(() => TabsController());
    Get.lazyPut(() => HomeController());
    Get.lazyPut(() => SearchController());
    AlanVoice.addButton(
        "67737059c5d2c83e73740f8a838359482e956eca572e1d8b807a3e2338fdd0dc/stage",
        buttonAlign: AlanVoice.BUTTON_ALIGN_LEFT);
  }
}

class TabsScreen extends GetView<AuthController> {
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
          Get.put(AlanController(playerController: Get.find<PlayerController>()));
          Get.put(WishlistController());
          AlanVoice.onCommand.add((command) {
            debugPrint("____________\n\ngot new command ${command.data}\n\n_____");
            Get.find<AlanController>().action(actionData: command.data);
          });
          print("isAnonymous: ${controller.isAnonymous}");
          print("access token: ${controller.accessToken}");
          return Obx(() => Scaffold(
                resizeToAvoidBottomInset: false,
                body: SafeArea(
                  child: tabsApp.elementAt(tabsController.currentIndex),
                ),
                bottomNavigationBar: BottomBarDefault(
                  items: const [
                    TabItem(
                      icon: Icons.home,
                      title: "Home",
                    ),
                    TabItem(
                      icon: Icons.search,
                      title: "Search",
                    ),
                    TabItem(
                      icon: Icons.person,
                      title: "Me",
                    ),
                  ],
                  backgroundColor: ColorSAU.primaryColor,
                  color: ColorSAU.textGreyLight,
                  colorSelected: GPColor.workPrimary,
                  animated: false,
                  indexSelected: tabsController.currentIndex,
                  iconSize: 20,
                  top: 5,
                  bottom: 5,
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
