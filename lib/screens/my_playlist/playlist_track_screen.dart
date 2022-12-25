import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_audio/common/widgets/track_tile.dart';
import 'package:smart_audio/constants/color.dart';
import 'package:smart_audio/screens/player/player_controller.dart';
import 'package:spotify/spotify.dart';

import 'my_playlist_track_controller.dart';

class MyPlaylistTrackScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MyPlaylistTrackController());
  }
}

class MyPlaylistTrackScreen extends GetView<MyPlaylistTrackController> {
  const MyPlaylistTrackScreen({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final Track emptyTrack = Track();
    return Scaffold(
      appBar: AppBar(
        title: Obx(() => Text(
          controller.playlistName,
          style: const TextStyle(
            color: ColorSAU.textGrey,
          ),
        )),
        backgroundColor: ColorSAU.primaryColor,
        centerTitle: true,
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: const Icon(
            Icons.arrow_back_ios_new_outlined,
            color: ColorSAU.secondaryColor,
          ),
        ),
      ),
      body: Obx(
        () {
          bool emptyWishlist = !controller.loadingTracks.value && controller.myPlaylistTracks.isEmpty;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10,),
              Expanded(
                child: (emptyWishlist)
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: const [
                            Icon(Icons.favorite, size: 50, color: ColorSAU.textGreyLight),
                            Text('Your liked tracks', style: TextStyle(fontSize: 22, color: ColorSAU.textGreyLight)),
                            SizedBox(
                              height: 50,
                            )
                          ],
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: (controller.loadingTracks.value)
                            ? ListView.builder(
                                itemBuilder: (context, index) {
                                  return TrackTile(
                                    index: index,
                                    track: emptyTrack,
                                    loading: true,
                                    onTapPlay: () {},
                                  );
                                },
                                itemCount: controller.trackCount,
                              )
                            : ListView.builder(
                                itemBuilder: (context, index) {
                                  return TrackTile(
                                    index: index,
                                    track: controller.myPlaylistTracks[index],
                                    loading: false,
                                    onTapPlay: () {
                                      Get.find<PlayerController>().playTrack(track: controller.myPlaylistTracks[index]);
                                    },
                                  );
                                },
                                itemCount: controller.myPlaylistTracks.length,
                              ),
                      ),
              ),
            ],
          );
        },
      ),
    );
  }
}
