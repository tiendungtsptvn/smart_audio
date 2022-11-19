
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../configs/path.dart';
import '../../../../generated/locales.g.dart';
import '../../../../theme/text_theme.dart';

class HeaderMenuFunction extends StatelessWidget{
  const HeaderMenuFunction({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            width: 16,
          ),
          const Spacer(),
          SizedBox(
            height: 44,
            child: Center(
              child: Text(
                LocaleKeys.chat_pick_function.tr,
                style: textStyle(GPTypography.headingMedium)
                    ?.merge(const TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),
          ),
          const Spacer(),
          SvgPicture.asset(
            AppPaths.iconClose,
            width: 16,
          ),
        ],
      ),
    );
  }

}