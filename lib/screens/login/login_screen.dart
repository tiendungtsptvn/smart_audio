import 'dart:math';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


import '../../configs/constants.dart';
import '../../generated/locales.g.dart';
import '../../theme/colors.dart';
import '../../theme/text_theme.dart';
import '../../utils/utils.dart';
import '../../widgets/auth_form_field.dart';
import 'mj_primary_button.dart';
import 'login_controller.dart';

class LoginScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LoginController());
  }
}

class LoginScreen extends GetView<LoginController> {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LoginController chatsController = Get.put(LoginController());
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      backgroundColor: GPColor.bgPrimary,
      body: Stack(
        children: [
          SafeArea(
              child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: Utils.isSmallDevice() ? 40 : 50),
                Image.asset(
                  "assets/images/Logo1.png",
                  width: min(274 / 375 * Get.width, 274),
                ),
                SizedBox(height: Utils.isSmallDevice() ? 16 : 60),
                Text(LocaleKeys.login_title.tr,
                    style: textStyle(Utils.isSmallDevice()
                        ? GPTypography.h2
                        : GPTypography.h1)),
                SizedBox(height: Utils.isSmallDevice() ? 16 : 24),
                AuthFormField(
                  inputTextStyle: textStyle(GPTypography.body20),
                  textCapitalization: TextCapitalization.none,
                  titleText: LocaleKeys.login_emailTitle.tr,
                  hintText: LocaleKeys.login_emailHint.tr,
                  controller: controller.usernameController,
                  maxLines: 1,
                ),
                SizedBox(height: Utils.isSmallDevice() ? 24 : 32),
                Stack(children: [
                  AuthFormField(
                    keyboardType: TextInputType.number,
                    textCapitalization: TextCapitalization.none,
                    inputTextStyle: textStyle(GPTypography.body20),
                    titleText: LocaleKeys.login_emailVerificationCodeTitle.tr,
                    hintText: LocaleKeys.login_sendCodeButton.tr,
                    controller: controller.verificationCodeController,
                    maxLines: 1,
                    rightView: SizedBox(
                      width: 64,
                      height: 64,
                      child: Center(
                        child: InkWell(
                            onTap: controller.sendCodeAction,
                            child: Obx(() => controller.remainTime.value ==
                                    Constants.maxOTPTime
                                ? Image.asset("assets/images/icon-send.png")
                                : Text(
                                    "${controller.remainTime}s",
                                    style: textStyle(GPTypography.body20)
                                        ?.mergeColor(controller
                                                .sendCodeButtonEnabled.value
                                            ? GPColor.functionCriticalPrimary
                                            : GPColor.contentSecondary),
                                  ))),
                      ),
                    ),
                  ),
                ]),
                const SizedBox(height: 4),
                Text(
                  LocaleKeys.login_signUpHint.tr,
                  style: textStyle(GPTypography.body)
                      ?.mergeColor(GPColor.contentSecondary)
                      .mergeFontSize(Utils.isSmallDevice() ? 14 : 16),
                ),
                const SizedBox(height: 32),
                Obx(() => MJPrimaryButton(
                    onTap: controller.isNextButtonEnabled.value
                        ? controller.onLogin
                        : null,
                    title: LocaleKeys.login_loginButton.tr,
                    isLoading: controller.isLoading.value,
                    isEnabled: controller.isNextButtonEnabled.value)),
                const SizedBox(height: 8),
                InkWell(
                  onTap: controller.showAccountLoginScreen,
                  child: Text(
                    LocaleKeys.login_accountLoginButton.tr,
                    style: textStyle(GPTypography.fontLink)?.merge(
                        const TextStyle(
                            decoration: TextDecoration.underline,
                            fontSize: 16)),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                        text: LocaleKeys.login_registerNote.tr,
                        style: textStyle(GPTypography.bodySmall),
                        children: <TextSpan>[
                          TextSpan(
                              text: LocaleKeys.login_agreementText.tr,
                              style: textStyle(GPTypography.bodySmall)
                                  ?.mergeColor(GPColor.functionNegativePrimary),
                              recognizer: TapGestureRecognizer()
                                ..onTap = controller.showAgreementAction),
                          TextSpan(
                              text: LocaleKeys.login_noteAndText.tr,
                              style: textStyle(GPTypography.bodySmall)),
                          TextSpan(
                              text: LocaleKeys.login_privacyText.tr,
                              style: textStyle(GPTypography.bodySmall)
                                  ?.mergeColor(GPColor.functionNegativePrimary),
                              recognizer: TapGestureRecognizer()
                                ..onTap = controller.showPrivacyAction),
                        ])),
                const SizedBox(height: 20)
              ],
            ),
          )),
        ],
      ).paddingOnly(left: 16, right: 16),
    );
  }
}
