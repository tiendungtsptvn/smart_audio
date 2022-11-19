import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_audio/screens/verification_code/verification_code_controller.dart';

import '../../generated/locales.g.dart';
import '../../theme/colors.dart';
import '../../theme/text_theme.dart';
import '../../utils/utils.dart';
import '../../widgets/auth_form_field.dart';
import '../login/mj_primary_button.dart';


class VerificationCodeScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => VerificationCodeController());
  }
}

class VerificationCodeScreen extends GetView<VerificationCodeController> {
  const VerificationCodeScreen({Key? key}) : super(key: key);

  void _openCommunity() async {
    // String url = "https://google.com";
    // if (await canLaunch(url)) {
    //   await launch(url);
    // }
    controller.getCode();
  }

  void _getCodeAction() async {
    Utils.showDialog(
        title: LocaleKeys.verifyCode_joinCommunityTitle.tr,
        message: LocaleKeys.verifyCode_joinCommunityMessage.tr,
        cancelText: LocaleKeys.alert_cancel.tr,
        confirmText: LocaleKeys.alert_go.tr,
        onConfirm: _openCommunity);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: GPColor.bgPrimary,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 164),
                Text(LocaleKeys.verifyCode_verifyCodeTitle.tr,
                    style: textStyle(GPTypography.h1)),
                const SizedBox(height: 70),
                AuthFormField(
                  inputTextStyle:
                      textStyle(GPTypography.body)?.mergeFontSize(20),
                  titleText: LocaleKeys.verifyCode_activationCodeTitle.tr,
                  hintText: LocaleKeys.verifyCode_activationCodeHint.tr,
                  controller: controller.codeController,
                  maxLines: 1,
                ),
                const SizedBox(height: 32),
                Obx(() => MJPrimaryButton(
                    onTap: controller.isNextButtonEnabled.value
                        ? controller.startVerify
                        : null,
                    isLoading: controller.isLoading.value,
                    title: LocaleKeys.verifyCode_startButton.tr,
                    isEnabled: controller.isNextButtonEnabled.value)),
                const SizedBox(height: 8),
                InkWell(
                  onTap: _getCodeAction,
                  child: Text(
                    LocaleKeys.verifyCode_getCodeButton.tr,
                    style: textStyle(GPTypography.fontLink)?.merge(
                        const TextStyle(
                            decoration: TextDecoration.underline,
                            fontSize: 20)),
                  ),
                )
              ],
            ).paddingOnly(left: 16, right: 16),
          ),
        ));
  }
}
