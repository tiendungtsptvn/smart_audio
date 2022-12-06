import 'package:flutter/material.dart';
import 'package:smart_audio/constants/color.dart';

class TileLibrary extends StatelessWidget {
  const TileLibrary({
    Key? key,
    required this.title,
    this.onTap,
    this.iconData,
  }) : super(key: key);
  final String title;
  final IconData? iconData;
  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 40,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: ColorSAU.backgroundCard,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Row(
          children: [
            if (iconData != null)
              Icon(
                iconData,
                color: ColorSAU.textGreyLight,
                size: 18,
              ),
            if (iconData != null)
              const SizedBox(width: 10,),
            Expanded(
                child: Text(
              title,
              style: TextStyle(
                fontSize: 16,
                color: ColorSAU.textGreyLight,
              ),
              maxLines: 1,
            )),
            Icon(Icons.arrow_forward_ios, color: ColorSAU.textGreyLight, size: 16,)
          ],
        ),
      ),
    );
  }
}
