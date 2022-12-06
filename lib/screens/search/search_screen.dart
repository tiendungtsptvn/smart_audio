import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_audio/common/common.dart';
import 'package:smart_audio/constants/color.dart';
import 'package:smart_audio/screens/player/player_controller.dart';
import 'package:spotify/spotify.dart';
import 'search_controller.dart';
import './widgets/search_field.dart';

class SearchScreen extends GetView<SearchController> {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Track emptyTrack = Track();
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Obx(() {
        bool isInitState = (controller.searching || controller.currentKeyword.isEmpty);
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(20),
              child: SearchTrackField(),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: Text(
                isInitState
                    ? ' '
                    : (controller.searchedTracks.isEmpty
                        ? 'Have 0 result for "${controller.currentKeyword}"'
                        : 'Result for "${controller.currentKeyword}" '),
              ),
            ),
            Expanded(
              child: (isInitState)
                  ? Center(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: const [
                          Icon(Icons.search, size: 50, color: ColorSAU.textGreyLight),
                          Text('Search SmartAudio', style: TextStyle(fontSize: 22, color: ColorSAU.textGreyLight)),
                          Text('Find artists and tracks', style: TextStyle(fontSize: 14, color: ColorSAU.textGreyLight)),
                          SizedBox(height: 50,)
                        ],
                      ),
                  )
                  : Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: (controller.searching)
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
                                  track: controller.searchedTracks[index],
                                  loading: false,
                                  onTapPlay: () {
                                    Get.find<PlayerController>().playTrack(track: controller.searchedTracks[index]);
                                  },
                                );
                              },
                              itemCount: controller.searchedTracks.length,
                            ),
                    ),
            ),
          ],
        );
      }),
    );
  }
}
