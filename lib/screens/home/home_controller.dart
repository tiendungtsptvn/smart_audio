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

  final RxList<PlaylistSimple> _topHitPlaylists = <PlaylistSimple>[].obs;

  final _loadingTopHitPlaylists = false.obs;

  final RxList<PlaylistSimple> _vietnamPlaylists = <PlaylistSimple>[].obs;

  final _loadingVietnamPlaylists = false.obs;

  final RxList<PlaylistSimple> _kPopPlaylists = <PlaylistSimple>[].obs;

  final _loadingKPopPlaylists = false.obs;

  List<PlaylistSimple> get featuredPlaylists => _featuredPlaylists;

  bool get loadingFeaturedPlaylists => _loadingFeaturedPlaylists.value;

  List<PlaylistSimple> get topHitPlaylists => _topHitPlaylists;

  bool get loadingTopHitPlaylists => _loadingTopHitPlaylists.value;

  List<PlaylistSimple> get vietnamPlaylists => _vietnamPlaylists;

  bool get loadingVietnamPlaylists => _loadingVietnamPlaylists.value;

  List<PlaylistSimple> get kPopPlaylists => _kPopPlaylists;

  bool get loadingKPopPlaylists => _loadingKPopPlaylists.value;

  SpotifyApi? spotifyApi = Get.find<PlayerController>().spotifyApi;

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

  Future<void> getTopHitPlaylists() async {
    try {

      _loadingTopHitPlaylists.value = true;
      List<PlaylistSimple> playlists = await _spotifyService.getPlaylistsById('toplists');
      _loadingTopHitPlaylists.value = false;
      _topHitPlaylists.value = playlists;
    } catch (_) {
      _loadingTopHitPlaylists.value = false;
    }
  }

  Future<void> getVietnamPlaylists() async {
    try {

      _loadingVietnamPlaylists.value = true;
      List<PlaylistSimple> playlists = await _spotifyService.getPlaylistsById('0JQ5DAqbMKFDBgllo2cUIN');
      _loadingVietnamPlaylists.value = false;
      _vietnamPlaylists.value = playlists;
    } catch (_) {
      _loadingVietnamPlaylists.value = false;
    }
  }

  Future<void> getKPopPlaylists() async {
    try {

      _loadingKPopPlaylists.value = true;
      List<PlaylistSimple> playlists = await _spotifyService.getPlaylistsById('0JQ5DAqbMKFGvOw3O4nLAf');
      _loadingKPopPlaylists.value = false;
      _kPopPlaylists.value = playlists;
    } catch (_) {
      _loadingKPopPlaylists.value = false;
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

  void testApi() async{
    if(spotifyApi != null){
      String? id = '';
      await spotifyApi!.categories.list(country: 'VN').all(10).then((value) {
        for(var i in value){
          debugPrint('${i.name} ${i.id}');
        }
        id = value.first.id;
      });

      await spotifyApi!.playlists.getByCategoryId(id ?? '').all(10).then((value) {
        for(var i in value){
          debugPrint('${i.name}');
        }
      });
    }
  }

  @override
  void onInit() {
    if (Get.find<PlayerController>().spotifyApi == null) {
      debugPrint("SpotifyApi null at home controller");
    }
    getFeaturedPlaylists();
    getTopHitPlaylists();
    getVietnamPlaylists();
    getKPopPlaylists();
    super.onInit();
  }
}
