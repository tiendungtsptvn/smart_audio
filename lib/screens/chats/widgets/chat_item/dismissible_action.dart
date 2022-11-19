
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../theme/colors.dart';
import '../../../../theme/text_theme.dart';

class DismissibleAction extends StatelessWidget {
  const DismissibleAction(
      {Key? key,
      required this.onTap,
      this.backgroundColor,
      required this.iconPath,
      this.iconColor,
      required this.text,
      this.flex,
      this.textColor})
      : super(key: key);
  final Function onTap;
  final Color? backgroundColor;
  final String iconPath;
  final Color? iconColor;
  final String text;
  final Color? textColor;
  final int? flex;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex ?? 1,
      child: InkWell(
        onTap: () {
          onTap();
        },
        child: Container(
          width: 80,
          color: backgroundColor ?? GPColor.bgTertiary,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                iconPath,
                color: iconColor,
              ),
              const SizedBox(
                height: 9,
              ),
              Text(
                text,
                style: textStyle(GPTypography.bodySmall)?.merge(
                  TextStyle(color: textColor ?? GPColor.contentPrimary),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
