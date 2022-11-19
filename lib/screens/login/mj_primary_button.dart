import 'package:flutter/material.dart';


import '../../theme/colors.dart';
import '../../theme/text_theme.dart';

class MJPrimaryButton extends StatelessWidget {
  final bool isEnabled;
  final String title;
  final void Function()? onTap;
  final GestureTapDownCallback? onTapDown;
  final GestureTapUpCallback? onTapUp;
  final void Function()? onTapCancel;
  final Color? color;
  final bool isLoading;

  const MJPrimaryButton(
      {Key? key,
      this.isEnabled = true,
      required this.title,
      this.onTap,
      this.onTapDown,
      this.onTapUp,
      this.onTapCancel,
      this.color,
      this.isLoading = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: onTapDown,
      onTapUp: onTapUp,
      onTapCancel: onTapCancel,
      onTap: () => isEnabled && onTap != null ? onTap?.call() : null,
      child: Container(
        height: 64,
        width: double.infinity,
        decoration: BoxDecoration(
          color: isEnabled ? null : GPColor.buttonDisabled,
          gradient: isEnabled
              ? const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xFFE59A18), Color(0xFFE55618)])
              : null,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Center(
          child: isLoading
              ? const CircularProgressIndicator(color: GPColor.bgPrimary)
              : Text(title,
                  style: textStyle(GPTypography.fontButton)?.copyWith(
                      height: 1,
                      color: isEnabled
                          ? GPColor.contentInversePrimary
                          : GPColor.contentTertiary)),
        ),
      ),
    );
  }
}
