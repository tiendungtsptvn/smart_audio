import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_audio/base/widgets/animated_shimmer.dart';
import 'package:smart_audio/common/common.dart';
import 'package:smart_audio/common/widgets/option_track_modal.dart';
import 'package:smart_audio/constants/color.dart';
import 'package:smart_audio/screens/player/player_controller.dart';
import 'package:smart_audio/utils/spotify_util.dart';
import 'package:spotify/spotify.dart';

class TrackTile extends GetView<PlayerController> {
  const TrackTile({
    Key? key,
    required this.index,
    required this.track,
    required this.loading,
    required this.onTapPlay,
  }) : super(key: key);
  final int index;
  final Track track;
  final bool loading;
  final Function() onTapPlay;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      margin: const EdgeInsets.symmetric(vertical: 2),
      duration: const Duration(milliseconds: 500),
      decoration: BoxDecoration(
        color: Theme.of(context).popupMenuTheme.color ?? Colors.transparent,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Material(
        type: MaterialType.transparency,
        child: Row(
          children: [
            SizedBox(
              height: 20,
              width: 25,
              child: Center(
                child: Text("${index + 1}"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 8.0,
                vertical: 8.0,
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(5)),
                child: (loading)
                    ? const AnimatedShimmer(width: 40, height: 40)
                    : CacheImageSAU(
                        url: getFirstImage(track.album?.images),
                        height: 40,
                        width: 40,
                      ),
              ),
            ),
            Obx(() {
              if (controller.playing && controller.currentTrack.id == track.id) {
                return IconButton(
                  icon: Icon(
                    Icons.pause_circle,
                    color: Theme.of(context).primaryColor,
                  ),
                  onPressed: (){},
                );
              }
              return IconButton(
                icon: Icon(
                  Icons.play_circle_rounded,
                  color: Theme.of(context).primaryColor,
                ),
                onPressed: onTapPlay,
              );
            }),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  (loading)
                      ? const AnimatedShimmer(width: 150, height: 15)
                      : Text(
                          track.name ?? '',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                  (loading)
                      ? const AnimatedShimmer(width: 70, height: 12)
                      : Text(
                          artistsToString(track.artists),
                          style: const TextStyle(fontSize: 12),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5, right: 10),
              child: IconButton(
                icon: const Icon(
                  Icons.more_horiz,
                  color: ColorSAU.textGrey,
                ),
                onPressed: (){
                  showModalBottomSheet(context: context, builder: (context) {
                    return  OptionTrackModal(track: track,);
                  },);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
