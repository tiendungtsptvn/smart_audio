import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_audio/screens/auth/auth_controller.dart';
import 'package:smart_audio/theme/colors.dart';

class SplashScreen extends GetView<AuthController> {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: GPColor.workPrimary,
      ),
    );
  }
}
