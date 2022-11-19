
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../configs/path.dart';
import '../../../../models/api/chat.dart';
import '../../../../theme/colors.dart';
import '../../../../theme/text_theme.dart';

class BodyChatItem extends StatelessWidget{
  const BodyChatItem({Key? key, required this.chat}) : super(key: key);
  final ChatModel chat;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(left: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    chat.name ?? "",
                    style: (chat.enableUnread())
                        ? textStyle(GPTypography.headingMedium)?.merge(
                        const TextStyle(fontWeight: FontWeight.bold))
                        : textStyle(GPTypography.bodyLarge),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                if (chat.isPinned())
                  const SizedBox(
                    width: 10,
                  ),
                if (chat.isPinned())
                  SvgPicture.asset(
                    AppPaths.iconFilledPin,
                  ),
                if (chat.enableUnread())
                  const SizedBox(
                    width: 10,
                  ),
                if (chat.enableUnread())
                  Container(
                    width: 16,
                    height: 16,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: GPColor.functionAccentWorkSecondary),
                    child: Center(
                      child: Text(
                        chat.getUnreadMessage().toString(),
                        style: textStyle(GPTypography.bodySmallBold)
                            ?.merge(const TextStyle(
                            color:
                            GPColor.functionAlwaysLightPrimary)),
                      ),
                    ),
                  )
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Text(
                    chat.lastMessage?.body ?? "",
                    style: textStyle(GPTypography.bodyMedium)?.merge(
                        (chat.enableUnread())
                            ? const TextStyle(
                            color: GPColor.contentPrimary,
                            fontWeight: FontWeight.bold)
                            : const TextStyle(
                          color: GPColor.contentSecondary,
                        )),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                SizedBox(
                  width: 65,
                  child: Text(
                    chat.getTimeLastMessage(),
                    style: textStyle(GPTypography.bodyMedium)?.merge(
                      const TextStyle(color: GPColor.contentSecondary),
                    ),
                    textAlign: TextAlign.end,
                    maxLines: 1,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

}