import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:smart_audio/common/widgets/add_playlist_modal.dart';
import 'package:smart_audio/constants/constants.dart';
import 'package:smart_audio/screens/wishlist_tracks/wishlist_controller.dart';
import 'package:spotify/spotify.dart';

class OptionTrackModal extends StatelessWidget {
  const OptionTrackModal({Key? key, required this.track}) : super(key: key);
  final TrackSimple track;
  @override
  Widget build(BuildContext context) {
    WishlistController wishlistController = Get.find<WishlistController>();
    return SizedBox(
      height: 280,
      child: Column(
        children: [
          Obx(() => TileOptionTrack(
                text: 'Like',
                prefixIcon:
                    wishlistController.currentWishlist.contains(track.id) ? Icons.favorite : Icons.favorite_border,
                onTap: () {
                  wishlistController.currentWishlist.contains(track.id)
                      ? wishlistController.removeFromWishlist(track.id)
                      : wishlistController.addToWishlist(track.id);
                },
              )),
          TileOptionTrack(
            text: 'Add to playlist',
            prefixIcon: Icons.add_box_outlined,
            onTap: () {
              Navigator.of(context).pop();
              showModalBottomSheet(
                context: context,
                builder: (context) {
                  return  AddPlaylistModal(track: track,);
                },
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                ),
              );
            },
          ),
          TileOptionTrack(
            text: 'Share',
            prefixIcon: Icons.share,
            onTap: () {
              if (track.href != null) {
                Share.share(track.href!);
              }
            },
          ),
          const TileOptionTrack(
            text: 'Report',
            prefixIcon: Icons.report_outlined,
          ),
          const Divider(
            color: ColorSAU.textGrey,
            height: 2,
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: const SizedBox(
              height: 50,
              child: Center(
                child: Text(
                  'Cancel',
                  style: TextStyle(
                    color: ColorSAU.textDarkWhite,
                    fontSize: SAUDouble.fontSizeNormal,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TileOptionTrack extends StatelessWidget {
  const TileOptionTrack({
    Key? key,
    this.text,
    this.prefixIcon,
    this.onTap,
  }) : super(key: key);
  final String? text;
  final IconData? prefixIcon;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: (text != null)
          ? Text(
              text!,
              style: const TextStyle(
                color: ColorSAU.textDarkWhite,
                fontSize: SAUDouble.fontSizeNormal,
              ),
            )
          : null,
      leading: (prefixIcon != null)
          ? Icon(
              prefixIcon!,
              color: ColorSAU.textDarkWhite,
              size: SAUDouble.iconSizeNormal,
            )
          : null,
      onTap: onTap,
    );
  }
}
