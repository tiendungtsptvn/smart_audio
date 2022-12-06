import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_audio/constants/constants.dart';
import 'package:smart_audio/screens/playlist/recommendation_controller.dart';
import 'package:spotify/spotify.dart';

import '../../base/widgets/animated_shimmer.dart';

import '../../theme/colors.dart';
import '../../utils/spotify_util.dart';
class RecommendationPlaylist extends StatelessWidget {
  const RecommendationPlaylist({Key? key, required this.tracks}) : super(key: key);
  final List<TrackSimple> tracks;
  @override
  Widget build(BuildContext context) {
    Get.put(RecommendationController());
    return RecommendationPlaylistBody(
      tracks: tracks,
    );
  }
}


class RecommendationPlaylistBody extends GetView<RecommendationController> {
  const RecommendationPlaylistBody({
    Key? key,
    required this.tracks,
  }) : super(key: key);
  final List<TrackSimple> tracks;
  @override
  Widget build(BuildContext context) {
    final List<Widget> buttons = [
      IconButton(
        icon: const Icon(
          Icons.share_rounded,
        ),
        onPressed: () {},
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
          onPressed: () {},
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
          expandedHeight: 200,
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
                'Recommended',
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
              background: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(StringSAU.defaultImage),
                    fit: BoxFit.cover,
                  ),
                ),
                child: BackdropFilter(
                  filter:
                  ImageFilter.blur(sigmaX: 40, sigmaY: 40),
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
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Recommended for you',
                                style: Theme.of(context).textTheme.headline4?.copyWith(
                                  color: Colors.white70,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              // if (description != null)
                              Text(
                                'Some songs you might like',
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
              ),
            );
          }),
        ),
        SliverList(
          delegate: SliverChildListDelegate(
            List<Widget>.generate(
                tracks.length,
                    (index) => TrackSimpleTile(
                  track: tracks[index],
                  loading: false,
                  index: index,
                  onTapPlay: () {
                    // if (!loading) {
                    //   playerController.playListTrack(
                    //     listTrack: controller.tracks,
                    //     playListId: controller.playlist.id,
                    //     index: index,
                    //   );
                    // }
                  },
                )).toList(),
          ),
        ),
      ],
    ));
  }
}

class TrackSimpleTile extends StatelessWidget {
  const TrackSimpleTile({
    Key? key,
    required this.index,
    required this.track,
    required this.loading,
    required this.onTapPlay,
  }) : super(key: key);
  final int index;
  final TrackSimple track;
  final bool loading;
  final Function() onTapPlay;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
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
            IconButton(
              icon: Icon(
                Icons.play_circle_rounded,
                color: Theme.of(context).primaryColor,
              ),
              onPressed: onTapPlay,
            ),
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
            const SizedBox(width: 10),
          ],
        ),
      ),
    );
  }
}
