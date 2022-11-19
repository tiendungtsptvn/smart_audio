import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_audio/screens/player/player_controller.dart';
import 'package:smart_audio/theme/colors.dart';

class MiniPlayerScreen extends GetView<PlayerController> {
  const MiniPlayerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.miniShowing) {
        return Dismissible(
          key: const Key('mini_player'),
          onDismissed: (dismissDirection){
            controller.hideMiniPlayer(pause: true);
          },
          child: Container(
            margin: controller.atHomeTab
                ? const EdgeInsets.only(left: 8, top: 8, right: 8, bottom: 73)
                : const EdgeInsets.all(8),
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(3),
              color: GPColor.workPrimary.withOpacity(0.5),
              border: Border.all(
                width: 2,
                color: GPColor.workPrimary,
              ),
            ),
            child: Row(
              children: [
                const Icon(Icons.music_note),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Text(
                    controller.currentTrack.name ?? '',
                    style: const TextStyle(
                      color: GPColor.workPrimary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                const Icon(Icons.skip_previous),
                const SizedBox(
                  width: 5,
                ),
                Obx(() => IconButton(
                  icon: (controller.playing) ? const Icon(Icons.pause) : const Icon(Icons.play_arrow),
                  onPressed: () {
                    controller.pauseOrResume();
                  },
                )),
                const SizedBox(
                  width: 5,
                ),
                const Icon(Icons.skip_next),
                const SizedBox(
                  width: 5,
                ),
              ],
            ),
          ),
        );
      }
      return const SizedBox.shrink();
    });
  }
}
