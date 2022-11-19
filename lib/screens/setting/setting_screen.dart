import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_audio/routes/router_name.dart';
import 'package:smart_audio/screens/auth/auth_controller.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthController authController = Get.find<AuthController>();
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children:  [
          const Text(
            " Account",
            style:
            TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          if (authController.isAnonymous)
            ListTile(
              leading: Icon(
                Icons.login_rounded,
                color: Theme.of(context).primaryColor,
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
        ],
      ),
    );
  }
}
