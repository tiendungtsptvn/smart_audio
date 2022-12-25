import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_audio/constants/color.dart';
import 'package:smart_audio/screens/auth/auth_controller.dart';

class SplashScreen extends GetView<AuthController> {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: ColorSAU.primaryColor,
        child: Center(
          child: Image.asset('assets/images/smart_audio_logo.png'),
        ),
      ),
    );
  }
}
