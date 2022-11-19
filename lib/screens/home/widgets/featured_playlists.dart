import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:smart_audio/constants/constants.dart';
import 'package:smart_audio/screens/home/home_controller.dart';
import 'package:spotify/spotify.dart';

import '../../../common/widgets/playlist_card.dart';

class FeaturedPlaylists extends GetView<HomeController> {
  const FeaturedPlaylists({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      List<PlaylistSimple> playlists = [];
      bool loading = controller.featuredPlaylists.isEmpty && controller.loadingFeaturedPlaylists;
      if(loading){
        playlists = List.generate(3, (index) => PlaylistSimple());
      }else{
        playlists = controller.featuredPlaylists;
      }
      if(!loading && playlists.isEmpty){
        return const Text("Empty list");
      }
      return SizedBox(
        height: SAUDouble.playlistCardHeight + 5,
        child: ListView.separated(
          physics: (loading) ? const NeverScrollableScrollPhysics() : null,
          separatorBuilder: (context, index) {
            return const SizedBox(width: 20,);
          },
          clipBehavior: Clip.none,
          itemCount: 8,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          itemBuilder: (context, index) {
            return  PlaylistCardItem(
              playlistSimple: playlists[index],
              onTap: (){
                controller.goToPlaylistScreen(playlistId: playlists[index].id ?? '');
              },
            );
          },
          scrollDirection: Axis.horizontal,
        ),
      );
    });
  }
}
