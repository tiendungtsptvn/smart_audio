import 'package:flutter/material.dart';


import '../theme/colors.dart';
import '../theme/text_theme.dart';
import '../utils/utils.dart';
import 'bottom_shadow_decoration.dart';

class MJAppBar extends AppBar {
  final bool hasBack;
  final bool isWhite;
  final bool bottomShadow;
  final String titleString;
  final PreferredSizeWidget? bottomWidget;
  final List<Widget>? rightViews;
  MJAppBar(
      {Key? key,
      this.hasBack = true,
      this.isWhite = true,
      this.titleString = '',
      this.bottomShadow = true,
      this.bottomWidget,
      this.rightViews})
      : super(
            key: key,
            elevation: 0,
            bottom: bottomShadow
                ? PreferredSize(
                    preferredSize: const Size.fromHeight(8),
                    child: Container(
                        height: 8, decoration: BottomShadowDecoration()))
                : bottomWidget,
            actions: rightViews,
            leading: hasBack
                ? BackButton(
                    color: isWhite
                        ? GPColor.contentPrimary
                        : GPColor.contentInversePrimary)
                : Container(),
            title: Text(
              titleString,
              style: textStyle(GPTypography.h2)
                  ?.mergeFontSize(Utils.isSmallDevice() ? 24 : 28),
              textAlign: TextAlign.center,
            ));
}
