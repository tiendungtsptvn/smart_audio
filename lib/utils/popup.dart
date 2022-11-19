import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:smart_audio/utils/utils.dart';

import '../generated/locales.g.dart';
import '../theme/buttons.dart';
import '../theme/colors.dart';
import '../theme/text_theme.dart';

enum SnackbarType { normal, error, success }

class Popup {
  Popup._();

  static final instance = Popup._();

  void showSnackBar({
    required String message,
    String? messageBold1,
    String? message2,
    String? messageBold2,
    String? message3,
    String? messageBold3,
    SnackbarType type = SnackbarType.normal,
    Duration duration = const Duration(seconds: 3),
    Duration animationDuration = const Duration(seconds: 1),
    SnackPosition? snackPosition = SnackPosition.TOP,
    Color backgroundColor = GPColor.bgInversePrimary,
  }) {
    Get.snackbar(
      '',
      '',
      titleText: const SizedBox(),
      padding: const EdgeInsets.only(left: 13, right: 12, top: 6, bottom: 12),
      margin: const EdgeInsets.all(16),
      backgroundColor: backgroundColor,
      snackPosition: snackPosition,
      borderRadius: 8,
      duration: duration,
      animationDuration: animationDuration,
      messageText: Row(
        children: [
          if (type == SnackbarType.success)
            Image.asset('assets/images/ic24-fill-checkmark-circle-green.png')
                .paddingOnly(right: 10),
          if (type == SnackbarType.error)
            Image.asset('assets/images/ic24-fill-xmark-circle.png')
                .paddingOnly(right: 10),
          Flexible(
            child: RichText(
              text: TextSpan(
                text: message,
                style: _snackBarTextStyleNormal(),
                children: <TextSpan>[
                  TextSpan(
                      text: messageBold1 ?? '',
                      style: _snackBarTextStyleBold()),
                  TextSpan(
                      text: message2 ?? '', style: _snackBarTextStyleNormal()),
                  TextSpan(
                      text: messageBold2 ?? '',
                      style: _snackBarTextStyleBold()),
                  TextSpan(
                      text: message3 ?? '', style: _snackBarTextStyleNormal()),
                  TextSpan(
                      text: messageBold3 ?? '',
                      style: _snackBarTextStyleBold()),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  TextStyle _snackBarTextStyleNormal() {
    return textStyle(GPTypography.bodyMedium)!.copyWith(
      fontWeight: FontWeight.w400,
      color: GPColor.functionAlwaysLightPrimary,
    );
  }

  TextStyle _snackBarTextStyleBold() {
    return _snackBarTextStyleNormal().copyWith(
      fontWeight: FontWeight.w700,
    );
  }

  void dismissSnackBar() {
    if (Get.isSnackbarOpen) {
      Get.back();
    }
  }

  Future showBottomSheet(
    Widget widget, {
    bool isScrollControlled = true,
    bool isDismissible = true,
  }) async {
    return await Get.bottomSheet(
        // wrap để auto height
        Wrap(
          children: <Widget>[
            widget.paddingOnly(bottom: Utils.getBottomSheetPadding())
          ],
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
        ),
        isScrollControlled: isScrollControlled,
        backgroundColor: GPColor.bgPrimary,
        isDismissible: isDismissible,
        enableDrag: isDismissible);
  }

  Future showAlert(
      {required String title,
      required String message,
      Widget? doneBtn,
      bool isDismissible = true}) async {
    return await showBottomSheet(
        _AlertView(title: title, message: message, doneBtn: doneBtn),
        isDismissible: isDismissible);
  }
}

class _AlertView extends StatelessWidget {
  const _AlertView({
    required this.title,
    required this.message,
    this.doneBtn,
    Key? key,
  }) : super(key: key);

  final String title;
  final String message;
  final Widget? doneBtn;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: true,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const SizedBox(height: 24),
        Text(
          title,
          style: textStyle(GPTypography.headingLarge),
        ),
        const SizedBox(height: 8),
        Text(
          message,
          style: textStyle(GPTypography.bodyLarge),
        ),
        const SizedBox(height: 12),
        doneBtn ?? BgSecondaryButton(LocaleKeys.alert_ok.tr, () => Get.back()),
        const SizedBox(height: 24),
      ]).paddingSymmetric(horizontal: 24),
    );
  }
}
