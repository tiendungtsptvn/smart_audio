import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:smart_audio/constants/color.dart';
import 'package:smart_audio/screens/player/player_controller.dart';
import 'package:smart_audio/screens/playlist/playlist_controller.dart';
import 'package:smart_audio/common/widgets/widgets.dart';
import 'package:smart_audio/theme/colors.dart';
import 'package:get/get.dart';
import 'package:spotify/spotify.dart' as spotify;

import '../../common/common.dart';
import '../../utils/spotify_util.dart';

class PlaylistScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PlaylistController());
  }
}

class PlaylistScreen extends GetView<PlaylistController> {
  const PlaylistScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PlayerController playerController = Get.find<PlayerController>();
    final List<Widget> buttons = [
      IconButton(
        icon:  Icon(
          Icons.share_rounded,
          color: ColorSAU.secondaryColor,
        ),
        onPressed: () {
          if(controller.playlist.href != null){
            Share.share(controller.playlist.href!);
          }
        },
      ),
      Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Theme.of(context).primaryColor),
            shape: MaterialStateProperty.all(
              const CircleBorder(),
            ),
          ),
          onPressed: () {
            bool loading = controller.tracks.isEmpty && controller.loadingTracks;
            if (!loading) {
              playerController.playListTrack(
                listTrack: controller.tracks,
                playListId: controller.playlist.id,
                index: 0,
              );
            }
          },
          child: const Icon(
            Icons.play_arrow_rounded,
          ),
        ),
      ),
    ];

    return Scaffold(
        body: CustomScrollView(
      controller: controller.scrollController,
      slivers: [
        SliverAppBar(
          floating: false,
          pinned: true,
          expandedHeight: 400,
          leading: InkWell(
            onTap: () {
              Get.back();
            },
            child: const Icon(
              Icons.arrow_back_ios_new_outlined,
              color: GPColor.workPrimary,
            ),
          ),
          iconTheme: const IconThemeData(color: GPColor.workPrimary),
          primary: true,
          backgroundColor: ColorSAU.primaryColor,
          title: Obx(() {
            if (!controller.collapse) {
              return Text(
                controller.playlist.name ?? '',
                style: Theme.of(context).textTheme.headline5?.copyWith(
                      color: ColorSAU.textGrey,
                      fontWeight: FontWeight.w600,
                    ),
              );
            }
            return const SizedBox.shrink();
          }),
          flexibleSpace: LayoutBuilder(builder: (context, constrains) {
            return FlexibleSpaceBar(
              background: Obx(() {
                bool loading = controller.loadingPlaylist;
                return Container(
                  decoration: (loading)
                      ? const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.white70,
                              Color(0xFF26282C),
                            ],
                            begin: FractionalOffset(0, 0),
                            end: FractionalOffset(0, 1),
                            tileMode: TileMode.clamp,
                          ),
                        )
                      : BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(getFirstImage(controller.playlist.images)),
                            fit: BoxFit.cover,
                          ),
                        ),
                  child: BackdropFilter(
                    filter:
                        (loading) ? ImageFilter.blur(sigmaX: 0, sigmaY: 0) : ImageFilter.blur(sigmaX: 40, sigmaY: 40),
                    child: Material(
                      type: MaterialType.transparency,
                      child: Padding(
                        padding: const EdgeInsets.only(
                          top: 50,
                          left: 20,
                          right: 20,
                        ),
                        child: Wrap(
                          spacing: 90,
                          runSpacing: 20,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          alignment: WrapAlignment.center,
                          runAlignment: WrapAlignment.center,
                          children: [
                            ///main image
                            (loading)
                                ? const SizedBox.shrink()
                                : Container(
                                    constraints: const BoxConstraints(maxHeight: 200),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: CacheImageSAU(
                                        url: getFirstImage(controller.playlist.images),
                                      ),
                                    ),
                                  ),

                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  controller.playlist.name ?? '',
                                  style: Theme.of(context).textTheme.headline4?.copyWith(
                                        color: Colors.white70,
                                        fontWeight: FontWeight.w600,
                                      ),
                                ),
                                // if (description != null)
                                Text(
                                  controller.playlist.description ?? '',
                                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                        color: Colors.white,
                                      ),
                                  maxLines: 2,
                                  overflow: TextOverflow.fade,
                                ),
                                // const SizedBox(height: 10),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    // mainAxisSize: MainAxisSize.min,
                                    children: buttons,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }),
            );
          }),
        ),
        Obx(() {
          bool loading = controller.tracks.isEmpty && controller.loadingTracks;
          return SliverList(
            delegate: SliverChildListDelegate(
              List<Widget>.generate(
                  loading ? 10 : controller.tracks.length,
                  (index) => TrackTile(
                        track: loading ? spotify.Track() : controller.tracks[index],
                        loading: loading,
                        index: index,
                        onTapPlay: () {
                          if (!loading) {
                            playerController.playListTrack(
                              listTrack: controller.tracks,
                              playListId: controller.playlist.id,
                              index: index,
                            );
                          }
                        },
                      )).toList(),
            ),
          );
        }),
      ],
    ));
  }
}
