import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../configs/constants.dart';
import '../../generated/locales.g.dart';
import '../../theme/colors.dart';
import '../../theme/text_theme.dart';
import '../../widgets/app_bar.dart';
import '../../widgets/auth_form_field.dart';
import '../login/mj_primary_button.dart';
import 'change_password_controller.dart';

class ChangePasswordScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ChangePasswordController());
  }
}

class ChangePasswordScreen extends GetView<ChangePasswordController> {
  const ChangePasswordScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: GPColor.bgPrimary,
        appBar: MJAppBar(titleString: controller.getTitle()),
        body: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(children: [
            const SizedBox(height: 8),
            AuthFormField(
              controller: controller.codeController,
              hintText: "",
              keyboardType: TextInputType.number,
              titleText: LocaleKeys.restoreWallet_emailCodeTitle.tr,
              rightView: SizedBox(
                width: 64,
                height: 64,
                child: Center(
                  child: InkWell(
                      onTap: controller.sendCodeAction,
                      child: Obx(() =>
                          controller.remainTime.value == Constants.maxOTPTime
                              ? Image.asset("assets/images/icon-send.png")
                              : Text(
                                  "${controller.remainTime}s",
                                  style: textStyle(GPTypography.body20)
                                      ?.mergeColor(
                                          controller.isEnableChangePass.value
                                              ? GPColor.functionCriticalPrimary
                                              : GPColor.contentSecondary),
                                ))),
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            controller.changePassType == ChangePassType.changePassword
                ? Column(
                    children: [
                      Obx(() => AuthFormField(
                            controller: controller.oldPasswordController,
                            hintText: "",
                            obscureText: controller.isSecuredOldPassword.value,
                            titleText:
                                LocaleKeys.changePassword_oldPasswordTitle.tr,
                            maxLines: 1,
                            rightView: SizedBox(
                              width: 64,
                              height: 64,
                              child: Center(
                                  child: InkWell(
                                      onTap: controller.toggleOldPasswordSecure,
                                      child: controller
                                              .isSecuredOldPassword.value
                                          ? Image.asset(
                                              "assets/images/icon-eye-slash.png")
                                          : Image.asset(
                                              "assets/images/icon-eye-login.png"))),
                            ),
                          )),
                      const SizedBox(height: 16)
                    ],
                  )
                : Container(),
            Obx(() => AuthFormField(
                  controller: controller.newPasswordController,
                  hintText: "",
                  obscureText: controller.isSecuredNewPassword.value,
                  titleText: LocaleKeys.changePassword_newPasswordTitle.tr,
                  maxLines: 1,
                  rightView: SizedBox(
                    width: 64,
                    height: 64,
                    child: Center(
                        child: InkWell(
                            onTap: controller.toggleNewPasswordSecure,
                            child: controller.isSecuredNewPassword.value
                                ? Image.asset(
                                    "assets/images/icon-eye-slash.png")
                                : Image.asset(
                                    "assets/images/icon-eye-login.png"))),
                  ),
                )),
            const SizedBox(height: 16),
            Obx(() => MJPrimaryButton(
                isLoading: controller.isLoading.value,
                isEnabled: controller.isEnableChangePass.value,
                title: LocaleKeys.changePassword_saveButton.tr,
                onTap: controller.saveAction))
          ]),
        )));
  }
}
