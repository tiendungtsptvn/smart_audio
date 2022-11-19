import 'dart:math';

import 'package:flutter/material.dart';
import 'package:smart_audio/theme/colors.dart';
import 'package:smart_audio/theme/text_theme.dart';

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}

class AuthFormField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode? focusNode;
  final int? minLines;
  final int? maxLines;
  final String hintText;
  final double height;
  final TextStyle? inputTextStyle;
  final String titleText;
  final Widget? rightView;
  final TextInputType? keyboardType;
  final bool obscureText;
  final Widget? leftIcon;
  final bool enabled;
  final TextCapitalization textCapitalization;
  final bool autoFocus;

  const AuthFormField(
      {Key? key,
      required this.controller,
      this.titleText = "",
      this.focusNode,
      required this.hintText,
      this.minLines,
      this.maxLines,
      this.height = 64,
      this.enabled = true,
      this.obscureText = false,
      this.inputTextStyle,
      this.keyboardType,
      this.leftIcon,
      this.autoFocus = false,
      this.textCapitalization = TextCapitalization.sentences,
      this.rightView})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      titleText.isEmpty
          ? Container()
          : Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(titleText,
                  style: textStyle(GPTypography.body)?.mergeFontSize(15.0)),
              const SizedBox(height: 4),
            ]),
      Stack(
        children: [
          TextFormField(
            enableInteractiveSelection: enabled,
            keyboardType: keyboardType,
            autofocus: autoFocus,
            obscureText: obscureText,
            textCapitalization: textCapitalization,
            style: (inputTextStyle ??
                textStyle(GPTypography.body)?.mergeFontSize(20)),
            decoration: InputDecoration(
              prefixIcon: leftIcon,
              contentPadding: EdgeInsets.only(
                  left: 16,
                  right: rightView != null ? 52 : 16,
                  top: min((height - 30) / 2, 17),
                  bottom: min((height - 30) / 2, 17)),
              hintText: hintText,
              hintStyle: (inputTextStyle ??
                      textStyle(GPTypography.body)?.copyWith(
                        fontWeight: FontWeight.w400,
                        fontSize: 20,
                        // height: 1,
                      ))
                  ?.copyWith(color: GPColor.contentSecondary),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(
                    color: GPColor.functionAccentWorkPrimary, width: 1),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide:
                    const BorderSide(width: 1, color: GPColor.linePrimary),
              ),
            ),
            maxLines: maxLines,
            minLines: minLines,
            controller: controller,
            focusNode: enabled ? focusNode : AlwaysDisabledFocusNode(),
          ),
          rightView != null
              ? Positioned(
                  child: Align(
                  alignment: Alignment.centerRight,
                  child: rightView!,
                ))
              : Container()
        ],
      )
    ]);
  }
}
