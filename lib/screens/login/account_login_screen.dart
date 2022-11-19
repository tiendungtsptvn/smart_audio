import 'package:flutter/material.dart';
import 'package:get/get.dart';


import '../../generated/locales.g.dart';
import '../../theme/colors.dart';
import '../../theme/text_theme.dart';
import '../../utils/utils.dart';
import '../../widgets/auth_form_field.dart';
import 'mj_primary_button.dart';
import 'account_login_controller.dart';

class AccountLoginScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AccountLoginController());
  }
}

class AccountLoginScreen extends GetView<AccountLoginController> {
  const AccountLoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GPColor.bgPrimary,
      body: Stack(
        children: [
          SafeArea(
              child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: Utils.isSmallDevice() ? 40 : 60),
                Image.asset("assets/images/Logo1.png", width: Get.width - 120),
                SizedBox(height: Utils.isSmallDevice() ? 20 : 60),
                Text(LocaleKeys.login_accountLoginButton.tr,
                    style: textStyle(GPTypography.h1)),
                SizedBox(height: Utils.isSmallDevice() ? 20 : 70),
                AuthFormField(
                  inputTextStyle: textStyle(GPTypography.body20),
                  textCapitalization: TextCapitalization.none,
                  titleText: LocaleKeys.login_emailTitle.tr,
                  hintText: LocaleKeys.login_emailHint.tr,
                  controller: controller.emailController,
                  maxLines: 1,
                ),
                SizedBox(height: Utils.isSmallDevice() ? 24 : 32),
                Stack(children: [
                  Obx(() => AuthFormField(
                        inputTextStyle: textStyle(GPTypography.body20),
                        titleText:
                            LocaleKeys.login_accountLogin_passwordTitle.tr,
                        textCapitalization: TextCapitalization.none,
                        hintText: LocaleKeys.login_accountLogin_passwordHint.tr,
                        controller: controller.passwordController,
                        maxLines: 1,
                        obscureText: controller.isSecuredPassword.value,
                        rightView: SizedBox(
                          width: 64,
                          height: 64,
                          child: Center(
                              child: InkWell(
                                  onTap: controller.togglePasswordSecure,
                                  child: controller.isSecuredPassword.value
                                      ? Image.asset(
                                          "assets/images/icon-eye-slash.png")
                                      : Image.asset(
                                          "assets/images/icon-eye-login.png"))),
                        ),
                      )),
                ]),
                const SizedBox(height: 32),
                Obx(() => MJPrimaryButton(
                    onTap: controller.isLoginButtonEnabled.value
                        ? controller.onLogin
                        : null,
                    title: LocaleKeys.login_loginButton.tr,
                    isLoading: controller.isLoading.value,
                    isEnabled: controller.isLoginButtonEnabled.value)),
                const SizedBox(height: 8),
                InkWell(
                  onTap: controller.showVerificationLogin,
                  child: Text(
                    LocaleKeys.login_verificationLogin_title.tr,
                    style: textStyle(GPTypography.fontLink)?.merge(
                        const TextStyle(
                            decoration: TextDecoration.underline,
                            fontSize: 16)),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
              ],
            ),
          )),
        ],
      ).paddingOnly(left: 16, right: 16),
    );
  }
}
