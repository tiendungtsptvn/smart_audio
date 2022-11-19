
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../theme/colors.dart';
import '../../../../theme/text_theme.dart';

class ItemMenuFunction extends StatelessWidget {
  const ItemMenuFunction({
    Key? key,
    this.onTap,
    this.showCountInfo = false,
    this.countInfo,
    required this.text,
    required this.iconPath,
  }) : super(key: key);
  final Function? onTap;
  final String text;
  final bool showCountInfo;
  final int? countInfo;
  final String iconPath;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (onTap != null) {
          onTap!();
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14),
        height: 48,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              iconPath,
            ),
            const SizedBox(
              width: 14,
            ),
            Text(
              text,
              style: textStyle(GPTypography.bodyLarge),
            ),
            if (showCountInfo)
              const SizedBox(
                width: 12,
              ),
            if (showCountInfo)
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: GPColor.functionNegativePrimary),
                child: Center(
                  child: Text(
                    (countInfo ?? 9).toString(),
                    textAlign: TextAlign.center,
                    style: textStyle(GPTypography.bodyMedium)?.merge(
                      const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: GPColor.functionAlwaysLightPrimary),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
