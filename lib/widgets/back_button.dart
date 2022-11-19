import 'dart:io';

import 'package:flutter/material.dart';
import 'package:smart_audio/utils/log.dart';
import 'package:smart_audio/utils/utils.dart';
import 'package:get/get.dart';

class GPBackButton extends StatelessWidget {
  final void Function()? action;

  const GPBackButton({
    Key? key,
    this.action,
  }) : super(key: key);

  void _onBack() {
    logDebug("back ${Get.previousRoute} ${Get.currentRoute}");
    Utils.back();
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: action ?? _onBack,
        icon: Image.asset(Platform.isAndroid
            ? "assets/images/ic24-line20-arrowleft.png"
            : "assets/images/ic-24-ios-back.png"));
  }
}
