import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:smart_audio/base/networking/services/spotify_api.dart';
import 'package:smart_audio/screens/player/player_controller.dart';
import 'package:spotify/spotify.dart';
import '../../base/controller/base_controller.dart';

class PlaylistController extends BaseController {
  final SpotifyService _spotifyService = SpotifyService(
    spotifyApi: Get.find<PlayerController>().spotifyApi!,
  );

  final Rx<Playlist> _playlist = Playlist().obs;

  final RxList<Track> _tracks = <Track>[].obs;



  final _loadingPlaylist = false.obs;

  final _loadingTracks = false.obs;

  final RxBool _collapse = true.obs;

  ScrollController scrollController = ScrollController();

  dynamic arguments = Get.arguments;

  Playlist get playlist => _playlist.value;

  List<Track> get tracks => _tracks;

  bool get loadingPlaylist => _loadingPlaylist.value;

  bool get loadingTracks => _loadingTracks.value;

  bool get collapse => _collapse.value;

  Future<void> getPlaylist({required String playlistId}) async {
    try {
      _loadingPlaylist.value = true;
      Playlist playlist = await _spotifyService.getPlaylist(
        playlistId: playlistId,
      );
      _loadingPlaylist.value = false;
      _playlist.value = playlist;
    } catch (_) {
      _loadingPlaylist.value = false;
      debugPrint('Get playlist error at controller');
    }
  }

  Future<void> getTracks({required String playlistId}) async {
    try {
      _loadingTracks.value = true;
      List<Track> tracks = await _spotifyService.getTracksInPlaylist(
        playlistId: playlistId,
      );
      tracks.removeWhere((element) => element.previewUrl == null);
      _loadingTracks.value = false;
      _tracks.value = [...tracks];
    } catch (_) {
      _loadingTracks.value = false;
      debugPrint('Get tracks error at controller');
    }
  }

  @override
  void onInit() async{
    
    if (Get.find<PlayerController>().spotifyApi == null) {
      debugPrint("SpotifyApi null at home controller");
    }
    
    scrollController.addListener(() {
      if (scrollController.position.pixels >= 350 && _collapse.value) {
        _collapse.value = false;
      } else if (scrollController.position.pixels < 350 && !_collapse.value) {
        _collapse.value = true;
      }
    });
    
    if(arguments['playlist_id'] != null){
      await getPlaylist(playlistId: arguments['playlist_id']);
      getTracks(playlistId: arguments['playlist_id']);
    }
    
    super.onInit();
  }
}
