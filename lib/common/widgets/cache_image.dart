// import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:smart_audio/constants/constants.dart';

class CacheImageSAU extends StatelessWidget {
  const CacheImageSAU({
    Key? key,
    required this.url,
    this.width,
    this.height,
    this.fit,
  }) : super(key: key);

  final String url;
  final double? width;
  final double? height;
  final BoxFit? fit;

  @override
  Widget build(BuildContext context) {
    return Image.network(
      url,
      width: width,
      height: height,
      fit: fit,
      errorBuilder: (context, url, error) {
        return Image.asset(
          StringSAU.errorImage,
          width: width,
          height: height,
        );
      },
      // progressIndicatorBuilder: (context, url, progress) => const CupertinoActivityIndicator(),
    );
  }
}
