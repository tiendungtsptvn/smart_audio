import 'package:flutter/material.dart';
import 'package:smart_audio/constants/color.dart';
import 'package:smart_audio/models/local/my_playlist.dart';

class MyPlaylistTile extends StatelessWidget {
  const MyPlaylistTile({
    Key? key,
    this.onTap,
    required this.playlist,
  }) : super(key: key);
  final Function()? onTap;
  final MyPlaylist playlist;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 40,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        margin: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          color: ColorSAU.backgroundCard,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Row(
          children: [
            const Padding(
              padding: EdgeInsets.only(right: 10.0),
              child: Icon(
                Icons.library_music,
                color: ColorSAU.textGreyLight,
                size: 18,
              ),
            ),
            Expanded(
                child: Text(
                  playlist.name,
                  style: const TextStyle(
                    fontSize: 16,
                    color: ColorSAU.textGreyLight,
                  ),
                  maxLines: 1,
                )),
            const Icon(Icons.arrow_forward_ios, color: ColorSAU.textGreyLight, size: 16,)
          ],
        ),
      ),
    );
  }
}
