import 'package:flutter/material.dart';
import 'package:smart_audio/theme/colors.dart';

class GPNetworkImage extends StatelessWidget {
  final String url;
  final Widget? placeholder;
  final double? width, height;
  final BoxFit? fit;
  final BorderRadiusGeometry? borderRadius;

  const GPNetworkImage({
    Key? key,
    required this.url,
    this.width,
    this.height,
    this.fit,
    this.placeholder,
    this.borderRadius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget placeholder = this.placeholder ??
        Container(width: width, height: height, color: GPColor.bgPrimary);
    if (url.isEmpty) {
      return placeholder;
    }
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        image: DecorationImage(image: NetworkImage(url), fit: fit),
      ),
    );
  }
}
