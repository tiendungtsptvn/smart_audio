import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marquee/marquee.dart';
import 'package:smart_audio/constants/color.dart';
import 'package:smart_audio/routes/router_name.dart';
import 'package:smart_audio/screens/player/player_controller.dart';

import '../../utils/spotify_util.dart';

class MiniPlayerScreen extends GetView<PlayerController> {
  const MiniPlayerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.miniShowing) {
        String trackName = controller.currentTrack.name ?? '';
        return Container(
          margin: controller.atHomeTab
              ? const EdgeInsets.only(left: 8, top: 8, right: 8, bottom: 55)
              : const EdgeInsets.all(8),
          child: Dismissible(
            key: const Key('mini_player'),
            onDismissed: (dismissDirection) {
              controller.hideMiniPlayer(pause: true);
            },
            child: InkWell(
              onTap: (){
                controller.hideMiniPlayer();
                Get.toNamed(RouterName.playerScreen);
              },
              child: Container(
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: ColorSAU.backgroundCard,
                  border: Border.all(
                    width: 1,
                    color: ColorSAU.primaryColor,
                  ),
                ),
                child: Row(
                  children: [
                    const SizedBox(
                      width: 5,
                    ),
                    const Icon(
                      Icons.music_note,
                      color: ColorSAU.secondaryColor,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          (trackName.length <= 30)
                          ? Text(
                            controller.currentTrack.name ?? '',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ) :
                          AutoSizeText(
                            trackName,
                            maxLines: 1,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                            ),
                              overflowReplacement: SizedBox(
                                width: 220,
                                height: 20,
                                child: Marquee(
                                  text: trackName,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                  ),
                                  scrollAxis: Axis.horizontal,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  velocity: 100.0,
                                  blankSpace: 20,
                                  pauseAfterRound: const Duration(seconds: 5),
                                  accelerationDuration: const Duration(seconds: 3),
                                  accelerationCurve: Curves.linear,
                                  decelerationDuration: const Duration(milliseconds: 500),
                                  decelerationCurve: Curves.easeOut,
                                ),
                              ),
                          ),
                          Text(
                            artistsToString(controller.currentTrack.artists),
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Obx(() => InkWell(
                      onTap: (){
                        if(!controller.singlePlay){
                          controller.previousTrack();
                        }
                      },
                      child: Icon(
                        Icons.skip_previous,
                        color: (!controller.singlePlay) ? ColorSAU.secondaryColor : ColorSAU.primaryColor,
                      ),
                    )),
                    const SizedBox(
                      width: 5,
                    ),
                    Obx(() => IconButton(
                          icon: (controller.playing) ? const Icon(Icons.pause) : const Icon(Icons.play_arrow),
                          onPressed: () {
                            controller.pauseOrResume();
                          },
                          color: ColorSAU.secondaryColor,
                        )),
                    const SizedBox(
                      width: 5,
                    ),
                    Obx(() => InkWell(
                      onTap: (){
                        if(!controller.singlePlay){
                          controller.nextTrack();
                        }
                      },
                      child: Icon(
                        Icons.skip_next,
                        color: (!controller.singlePlay) ? ColorSAU.secondaryColor : ColorSAU.primaryColor,
                      ),
                    )),
                    const SizedBox(
                      width: 5,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }
      return const SizedBox.shrink();
    });
  }
}
