import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_audio/constants/color.dart';
import 'package:smart_audio/routes/router_name.dart';
import 'package:smart_audio/screens/auth/auth_controller.dart';
import 'package:smart_audio/screens/setting/widgets/tile.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthController authController = Get.find<AuthController>();
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children:  [
            const SizedBox(height: 20,),
             const Text(
              "Account",
              style:
              TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: ColorSAU.textGreyLight),
            ),
            if (authController.isAnonymous)
              ListTile(
                leading: Icon(
                  Icons.login_rounded,
                  color: Theme.of(context).primaryColor,
                  size: 20,
                ),
                title: SizedBox(
                  height: 50,
                  width: 200,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Login with your Spotify account",
                      maxLines: 1,
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 16
                      ),
                    ),
                  ),
                ),
                onTap: (){
                  Get.toNamed(RouterName.loginWebView);
                },
              ),
            if (authController.isLoggedIn)
              const ListTile(
                leading: Icon(Icons.logout_rounded),
                title: SizedBox(
                  height: 50,
                  width: 180,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Log out of this account",
                      maxLines: 1,
                    ),
                  ),
                ),
              ),
             const Text(
              "Library",
              style:
              TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: ColorSAU.textGreyLight,),
            ),
            const SizedBox(height: 10,),
            TileLibrary(
              title: 'Liked tracks',
              iconData: Icons.favorite,
              onTap: (){
                Get.toNamed(RouterName.wishlist);
              },
            ),
            const SizedBox(height: 10,),
            TileLibrary(
              title: 'Playlist',
              iconData: Icons.library_music,
              onTap: (){
                Get.toNamed(RouterName.myPlaylistScreen);
              },
            ),
            const SizedBox(height: 10,),
            TileLibrary(
              title: 'Recommended for you',
              iconData: Icons.recommend,
              onTap: (){
              },
            ),
            const SizedBox(height: 10,),
            const Text(
              "Information",
              style:
              TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: ColorSAU.textGreyLight,),
            ),
            const SizedBox(height: 10,),
            TileLibrary(
              title: 'App information',
              iconData: Icons.info,
              onTap: (){
              },
            ),
          ],
        ),
      ),
    );
  }
}
