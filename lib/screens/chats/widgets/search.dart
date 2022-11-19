
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../configs/path.dart';
import '../../../generated/locales.g.dart';
import '../../../theme/colors.dart';
import '../../../theme/text_theme.dart';
import '../chats_controller.dart';

class SearchChats extends GetView<ChatsController> {
  const SearchChats({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return CupertinoTextField(
      placeholderStyle: textStyle(GPTypography.body16),
      textInputAction: TextInputAction.next,
      placeholder: LocaleKeys.chat_search.tr,
      style: textStyle(GPTypography.body16),
      prefix: Padding(
        padding: const EdgeInsets.only(left: 13, right: 10),
        child: SvgPicture.asset(
          AppPaths.iconSearch,
          color: GPColor.hintTextInput,
          fit: BoxFit.fill,
          width: 13,
          height: 13,
        ),
      ),
      padding: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        color: GPColor.textFieldBkg,
        borderRadius: BorderRadius.circular(20),
      ),
      autocorrect: false,
      onChanged: (keyword) {
        controller.onchangeSearch(keyword: keyword);
      },
    );
  }
}
