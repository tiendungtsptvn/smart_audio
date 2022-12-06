import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smart_audio/constants/color.dart';

import '../../theme/colors.dart';

class AnimatedShimmer extends StatelessWidget {
  final double width;
  final double height;
  final double radius;
  final Widget? child;

  const AnimatedShimmer({
    Key? key,
    this.child,
    required this.width,
    required this.height,
    this.radius = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color color = Theme.of(context).colorScheme.surface;

    if (kIsWeb) {
      Container c = child as Container;

      return child ??
          Container(
            width: c.constraints!.minWidth,
            height: c.constraints!.minHeight,
            color: color,
          );
    }
    return Shimmer.fromColors(
      baseColor: ColorSAU.shimmerColor,
      highlightColor: ColorSAU.shimmerLightColor,
      child: child ??
          Container(
            width: width,
            height: height,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(radius), color: ColorSAU.shimmerColor),
          ),
    );
  }
}
