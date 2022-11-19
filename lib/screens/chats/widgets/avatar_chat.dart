import 'package:flutter/cupertino.dart';

import '../../../configs/path.dart';
import '../../../theme/colors.dart';

class AvatarChat extends StatelessWidget{
  const AvatarChat({Key? key, required this.imageUrl,
  required this.width,
  required this.height, required this.isActive,}) : super(key: key);
  final String? imageUrl;
  final double width;
  final double height;
  final bool isActive;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: Image.network(
              imageUrl ?? "",
              errorBuilder: (context, error, stackTrace) {
                return   Image(
                  image: const AssetImage(AppPaths.defaultImage),
                  height: height,
                  width: width,
                  fit: BoxFit.fill,
                );
              },
              height: height,
              width: width,
              fit: BoxFit.fill,
            ),
          ),
          if (isActive)
            Positioned(
              right: 0,
              bottom: 0,
              child: Container(
                width: width/4,
                height: height/4,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: GPColor.workPrimary,
                  border:
                  Border.all(width: 1, color: GPColor.bgPrimary),
                ),
              ),
            )
        ],
      ),
    );
  }

}