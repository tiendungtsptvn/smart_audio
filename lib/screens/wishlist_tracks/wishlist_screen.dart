import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_audio/constants/color.dart';
import 'package:smart_audio/screens/wishlist_tracks/wishlist_controller.dart';
import 'package:spotify/spotify.dart';

import '../../common/widgets/track_tile.dart';
import '../player/player_controller.dart';

class WishlistScreen extends GetView<WishlistController> {
  const WishlistScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Track emptyTrack = Track();
    controller.getWishlist();
    return Scaffold(
      appBar: AppBar(
        title: const Text(
            'Liked Tracks',
            style: TextStyle(
              color: ColorSAU.textGrey,
            ),
        ),
        backgroundColor: ColorSAU.primaryColor,
        centerTitle: true,
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child:  const Icon(
            Icons.arrow_back_ios_new_outlined,
            color: ColorSAU.secondaryColor,
          ),
        ),
      ),
      body: Obx(
        () {
          bool emptyWishlist = !controller.loadingTracks.value && controller.wishlistTracks.isEmpty;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15.0, top: 10),
                child: Text(
                  controller.loadingTracks.value
                      ? ' '
                      : 'You liked ${controller.wishlistTracks.length} track(s)',
                ),
              ),
              Expanded(
                child: (emptyWishlist)
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      Icon(Icons.favorite, size: 50, color: ColorSAU.textGreyLight),
                      Text('Your liked tracks', style: TextStyle(fontSize: 22, color: ColorSAU.textGreyLight)),
                      SizedBox(height: 50,)
                    ],
                  ),
                )
                :Padding(
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
                    itemCount: 3,
                  )
                      : ListView.builder(
                    itemBuilder: (context, index) {
                      return TrackTile(
                        index: index,
                        track: controller.wishlistTracks[index],
                        loading: false,
                        onTapPlay: () {
                          Get.find<PlayerController>().playTrack(track: controller.wishlistTracks[index]);
                        },
                      );
                    },
                    itemCount: controller.wishlistTracks.length,
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
