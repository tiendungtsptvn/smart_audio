import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_audio/base/networking/services/spotify_api.dart';
import 'package:smart_audio/screens/player/player_controller.dart';
import 'package:spotify/spotify.dart';
import '../../base/controller/base_controller.dart';

class MyPlaylistTrackController extends BaseController {
  final SpotifyService _spotifyService = SpotifyService(
    spotifyApi: Get.find<PlayerController>().spotifyApi!,
  );

  final RxString _playlistName = ''.obs;

  final RxList<Track> _myPlaylistTracks = <Track>[].obs;

  final RxBool loadingTracks = false.obs;

  final RxInt _trackCount = 0.obs;

  List<Track> get myPlaylistTracks => _myPlaylistTracks;

  String get playlistName => _playlistName.value;

  int get trackCount => _trackCount.value;

  dynamic arguments = Get.arguments;

  Future<void> getPlaylistTrack({required List<String> trackIds}) async {
    try {
      loadingTracks.value = true;
      final tracks = await _spotifyService.getSeveralTracks(trackIds: trackIds);
      loadingTracks.value = false;
      _myPlaylistTracks.value = tracks;
    } catch (e) {
      loadingTracks.value = false;
      debugPrint('Error when get my playlist tracks: $e');
    }
  }

  @override
  void onInit() {
    if (arguments['track_id'] != null) {
      getPlaylistTrack(trackIds: (arguments['track_id'] as List).map((e) => e.toString()).toList());
      _trackCount.value = (arguments['track_id'] as List).length;
    }
    if (arguments['playlist_name'] != null) {
      _playlistName.value = arguments['playlist_name'] as String;
    }
    super.onInit();
  }
}
