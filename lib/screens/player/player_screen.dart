import 'dart:ui';

import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_audio/common/common.dart';
import 'package:smart_audio/constants/constants.dart';
import 'package:smart_audio/screens/player/player_controller.dart';
import 'package:smart_audio/screens/wishlist_tracks/wishlist_controller.dart';

import '../../utils/spotify_util.dart';

class PlayerScreen extends GetView<PlayerController> {
  const PlayerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final WishlistController wishlistController = Get.find<WishlistController>();
    final double maxWidth = MediaQuery.of(context).size.width;
    final imageWidth = maxWidth - 60;
    return Obx(() => Container(
      decoration:  BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(getFirstImage(controller.currentTrack.album?.images)),
          fit: BoxFit.cover,
        ),
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 40, sigmaY: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 30, bottom: 20),
              child: InkWell(
                onTap: () {
                  controller.showMiniPlayer();
                  Get.back();
                },
                child: const Icon(
                  Icons.keyboard_arrow_down,
                  color: Colors.white,
                  size: 30,
                ),
              ),
            ),
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CacheImageSAU(
                  url: getFirstImage(controller.currentTrack.album?.images),
                  width: imageWidth,
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
             SizedBox(
               height: 100,
               child: Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 mainAxisAlignment: MainAxisAlignment.center,
                 children: [
                   Padding(
                     padding: const EdgeInsets.only(left: 30, right: 30, top: 20),
                     child: Text(
                       controller.currentTrack.name ?? '',
                       style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                       overflow: TextOverflow.ellipsis,
                       maxLines: 2,
                     ),
                   ),
                   Padding(
                     padding: const EdgeInsets.symmetric(horizontal: 30),
                     child: Text(
                       artistsToString(controller.currentTrack.artists),
                       style: const TextStyle(fontSize: 14),
                       overflow: TextOverflow.ellipsis,
                       maxLines: 1,
                     ),
                   ),
                 ],
               ),
             ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              child: Obx(() => ProgressBar(
                progress: controller.progressPlayer,
                buffered: controller.bufferedPlayer,
                total: controller.durationPlayer ?? Duration.zero,
                onSeek: (position) {
                  controller.seekPlayer(position: position);
                },
                baseBarColor: Colors.white.withOpacity(0.1),
                progressBarColor: ColorSAU.textDarkWhite,
                bufferedBarColor: Colors.white.withOpacity(0.4),
                thumbColor: Colors.white,
              )),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Row(
                children: [
                  Obx(() {
                    if(wishlistController.currentWishlist.contains(controller.currentTrack.id)){
                      return InkWell(
                        onTap: (){
                          wishlistController.removeFromWishlist(controller.currentTrack.id);
                        },
                        child: Image.asset(
                          StringSAU.heartFilled,
                          width: 24,
                          height: 24,
                          color: ColorSAU.textDarkWhite,
                        ),
                      );
                    }
                    return InkWell(
                      onTap: (){
                        wishlistController.addToWishlist(controller.currentTrack.id);
                      },
                      child: Image.asset(
                        StringSAU.heart,
                        width: 24,
                        height: 24,
                        color: ColorSAU.textDarkWhite,
                      ),
                    );
                  }),
                  const Spacer(),
                  Obx(() => InkWell(
                    onTap: (){
                      if(!controller.singlePlay){
                        controller.previousTrack();
                      }
                    },
                    child: Icon(
                      Icons.skip_previous,
                      color: (!controller.singlePlay) ?  Colors.white : Colors.white.withOpacity(0.3),
                      size: 45,
                    ),
                  )),
                  const SizedBox(
                    width: 25,
                  ),
                  Obx(() => IconButton(
                    icon: (controller.playing) ? const Icon(Icons.pause) : const Icon(Icons.play_arrow),
                    onPressed: () {
                      controller.pauseOrResume();
                    },
                    iconSize: 45,
                    color: Colors.white,
                  )),
                  const SizedBox(
                    width: 25,
                  ),
                  Obx(() => InkWell(
                    onTap: (){
                      if(!controller.singlePlay){
                        controller.nextTrack();
                      }
                    },
                    child: Icon(
                      Icons.skip_next,
                      color: (!controller.singlePlay) ? Colors.white : Colors.white.withOpacity(0.3),
                      size: 45,
                    ),
                  )),
                  const Spacer(),
                  const Icon(
                    Icons.add,
                    size: 35,
                    color: ColorSAU.textDarkWhite,
                  )
                ],
              ),
            )
            // CacheImageSAU(url: url)
          ],
        ),
      ),
    ));
  }
}
