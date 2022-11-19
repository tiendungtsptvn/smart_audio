import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/widget_extensions.dart';
import 'package:smart_audio/theme/colors.dart';
import 'package:smart_audio/theme/text_theme.dart';

class LineBorderButton extends StatelessWidget {
  final String text;
  final void Function()? onTap;
  final String? leftIcon;
  final double height;
  const LineBorderButton(
      {Key? key, this.text = "", this.onTap, this.leftIcon, this.height = 64})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
        child: InkWell(
            onTap: onTap,
            child: Container(
              height: height,
              decoration: BoxDecoration(
                  color: GPColor.bgPrimary,
                  border: Border.all(color: GPColor.bgInversePrimary),
                  borderRadius: BorderRadius.circular(16)),
              child: Center(
                      child: leftIcon != null
                          ? Row(children: [
                              Image.asset(leftIcon!),
                              const SizedBox(width: 4),
                              Text(
                                text,
                                style: textStyle(GPTypography.fontButton),
                              ).marginOnly(bottom: 4)
                            ]).paddingOnly(left: 16, right: 16)
                          : Text(
                              text,
                              style: textStyle(GPTypography.fontButton),
                            ).marginOnly(bottom: 4))
                  .paddingOnly(left: 16, right: 16),
            )));
  }
}
