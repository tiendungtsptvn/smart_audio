import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:smart_audio/base/networking/services/spotify_api.dart';
import 'package:smart_audio/screens/player/player_controller.dart';
import 'package:spotify/spotify.dart';
import '../../base/controller/base_controller.dart';
import '../../routes/router_name.dart';

class HomeController extends BaseController {
  final SpotifyService _spotifyService = SpotifyService(
    spotifyApi: Get.find<PlayerController>().spotifyApi!,
  );

  final RxList<PlaylistSimple> _featuredPlaylists = <PlaylistSimple>[].obs;

  final _loadingFeaturedPlaylists = false.obs;

  List<PlaylistSimple> get featuredPlaylists => _featuredPlaylists;

  bool get loadingFeaturedPlaylists => _loadingFeaturedPlaylists.value;

  Future<void> getFeaturedPlaylists() async {
    try {
      _loadingFeaturedPlaylists.value = true;
      List<PlaylistSimple> playlists = await _spotifyService.getFeaturedPlaylist();
      _loadingFeaturedPlaylists.value = false;
      _featuredPlaylists.value = playlists;
    } catch (_) {
      _loadingFeaturedPlaylists.value = false;
    }
  }

  void goToPlaylistScreen({required String playlistId}) {
    Get.toNamed(
      RouterName.playlist,
      arguments: {
        'playlist_id': playlistId,
      },
    );
  }

  @override
  void onInit() {
    if (Get.find<PlayerController>().spotifyApi == null) {
      debugPrint("SpotifyApi null at home controller");
    }
    getFeaturedPlaylists();
    super.onInit();
  }
}
