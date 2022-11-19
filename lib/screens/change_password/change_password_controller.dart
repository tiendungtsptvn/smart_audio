import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_audio/utils/string_utils.dart';

import '../../base/controller/base_controller.dart';
import '../../base/networking/services/auth_api.dart';
import '../../configs/constants.dart';
import '../../generated/locales.g.dart';
import '../../models/token/token_manager.dart';
import '../../utils/log.dart';
import '../../utils/popup.dart';

enum ChangePassType { setNewPassword, changePassword }

class ChangePasswordController extends BaseController {
  TextEditingController codeController = TextEditingController();
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  final AuthAPI _api = AuthAPI();

  RxString code = "".obs;
  RxString oldPassword = "".obs;
  RxString newPassword = "".obs;
  RxBool isEnableChangePass = false.obs;
  RxInt remainTime = Constants.maxOTPTime.obs;
  Timer? _timer;
  ChangePassType changePassType = ChangePassType.setNewPassword;
  RxBool isSecuredOldPassword = true.obs;
  RxBool isSecuredNewPassword = true.obs;

  @override
  void onClose() {
    codeController.dispose();
    oldPasswordController.dispose();
    newPasswordController.dispose();
    if (_timer != null) {
      _timer?.cancel();
    }
    super.onClose();
  }

  @override
  void onInit() {
    super.onInit();
    changePassType = TokenManager.userInfo?.status == 3
        ? ChangePassType.changePassword
        : ChangePassType.setNewPassword;
    _binding();
  }

  void _binding() {
    codeController.addListener(() {
      code.value = codeController.text;
      _checkEnable();
    });
    oldPasswordController.addListener(() {
      oldPassword.value = oldPasswordController.text;
      _checkEnable();
    });
    newPasswordController.addListener(() {
      newPassword.value = newPasswordController.text;
      _checkEnable();
    });
  }

  void toggleOldPasswordSecure() {
    isSecuredOldPassword.value = !isSecuredOldPassword.value;
  }

  void toggleNewPasswordSecure() {
    isSecuredNewPassword.value = !isSecuredNewPassword.value;
  }

  String getTitle() {
    return changePassType == ChangePassType.changePassword
        ? LocaleKeys.changePassword_title.tr
        : LocaleKeys.changePassword_setPasswordTitle.tr;
  }

  void _checkEnable() {
    bool isEnable = code.value.isNotEmpty && newPassword.isNotEmpty;
    if (changePassType == ChangePassType.changePassword) {
      isEnable = isEnable && oldPassword.isNotEmpty;
    }
    if (isEnable != isEnableChangePass.value) {
      isEnableChangePass.value = isEnable;
    }
  }

  void sendCodeAction() async {
    if (remainTime.value != Constants.maxOTPTime) return;
    _startTimer();
    try {
      var response =
          await _api.requestEmailOTP(TokenManager.userInfo?.email ?? "");
      if (response) {
        Popup.instance.showSnackBar(
            message: LocaleKeys.login_sendCodeSuccess.tr,
            type: SnackbarType.success);
      } else {}
    } catch (error) {
      logDebug("get list error $error");
      handleError(error);
    }
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainTime.value == 1) {
        remainTime.value = Constants.maxOTPTime;
        timer.cancel();
      } else {
        remainTime.value = remainTime.value - 1;
      }
    });
  }

  void saveAction() {
    if (!newPassword.value.isValidPassword()) {
      Popup.instance.showSnackBar(
          message: LocaleKeys.login_passwordInvalid.tr,
          type: SnackbarType.error);
      return;
    }
    if (changePassType == ChangePassType.setNewPassword) {
      setPasswordAction();
    } else {
      changePasswordAction();
    }
  }

  void changePasswordAction() async {
    if (isLoading.value) return;
    isLoading.value = true;
    try {
      var response = await _api.changePassword(
          oldPassword.value, newPassword.value, code.value);
      isLoading.value = false;
      if (response.accessToken.isNotEmpty) {
        _setPasswordSuccess(response.accessToken);
      } else {}
    } catch (error) {
      logDebug("get list error $error");
      handleError(error);
    }
  }

  void setPasswordAction() async {
    if (isLoading.value) return;
    isLoading.value = true;
    try {
      var response = await _api.setPassword(newPassword.value, code.value);
      isLoading.value = false;
      if (response.accessToken.isNotEmpty) {
        _setPasswordSuccess(response.accessToken);
      } else {}
    } catch (error) {
      logDebug("get list error $error");
      handleError(error);
    }
  }

  void _setPasswordSuccess(String newToken) {
    Get.back(result: true);
    Popup.instance.showSnackBar(
        message: LocaleKeys.changePassword_changePasswordSuccess.tr,
        type: SnackbarType.success);
    TokenManager.saveAccessToken(newToken);
    TokenManager.userInfo?.status = 2;
    TokenManager.saveUser(TokenManager.userInfo);
  }
}
