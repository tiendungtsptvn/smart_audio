import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_audio/common/widgets/playlist_card.dart';
import 'package:smart_audio/screens/auth/auth_controller.dart';
import 'package:smart_audio/screens/home/home_controller.dart';
import 'package:smart_audio/screens/home/widgets/featured_playlists.dart';
import 'package:smart_audio/screens/player/player_controller.dart';
import 'package:smart_audio/theme/colors.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    PlayerController playerController = Get.find<PlayerController>();
    AuthController authController = Get.find<AuthController>();
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        // const Text("Home Screen"),
        // InkWell(
        //   onTap: (){
        //     playerController.showMiniPlayer();
        //   },
        //     child: const Icon(Icons.play_circle,size: 30,color: GPColor.workPrimary,),
        // ),
        // Obx(() => Text(authController.count.toString())),
        // ElevatedButton(
        //   style: ButtonStyle(
        //     backgroundColor:
        //     MaterialStateProperty.all(Colors.red),
        //     foregroundColor:
        //     MaterialStateProperty.all(Colors.white),
        //   ),
        //   onPressed: ()  {
        //     authController.addCount();
        //   },
        //   child: const Text("Add"),
        // ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Text(
            "Featured",
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
          ),
        ),
        FeaturedPlaylists(),
      ],
    );
  }
}
