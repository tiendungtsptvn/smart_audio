
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:smart_audio/base/networking/services/spotify_api.dart';
import 'package:smart_audio/constants/constants.dart';
import 'package:smart_audio/models/local/my_playlist.dart';
import 'package:smart_audio/screens/player/player_controller.dart';
import 'package:spotify/spotify.dart';
import '../../base/controller/base_controller.dart';

class MyPlaylistController extends BaseController {
  final SpotifyService _spotifyService = SpotifyService(
    spotifyApi: Get.find<PlayerController>().spotifyApi!,
  );

  final storage = GetStorage();

  final RxList<Track> _myPlaylistTracks = <Track>[].obs;

  final RxBool loadingTracks = false.obs;

  List<Track> get myPlaylistTracks => _myPlaylistTracks;

  final RxList<MyPlaylist> _myPlaylists = <MyPlaylist>[].obs;

  List<MyPlaylist> get myPlaylists => _myPlaylists;

  void addNewPlaylist(String name){
    List<MyPlaylist> playlists = [..._myPlaylists];
    playlists.add(MyPlaylist(name: name, tracks: []));
    _myPlaylists.value = playlists;
    storage.write(StringSAU.myPlaylistKeyStore, playlists.map((e) => e.toJson()).toList());
  }

  void removePlaylist(String name){
    List<MyPlaylist> playlists = [..._myPlaylists];
    playlists.removeWhere((element) => element.name == name);
    _myPlaylists.value = playlists;
    storage.write(StringSAU.myPlaylistKeyStore, playlists.map((e) => e.toJson()).toList());
  }

  void addTrackToPlaylist({String? trackId,required String playlistName}){
    if(trackId != null){
      List<MyPlaylist> playlists = [..._myPlaylists];
      List<String> tracks = playlists.firstWhere((element) => element.name == playlistName).tracks;
      if(!tracks.contains(trackId)){
        playlists.firstWhere((element) => element.name == playlistName).tracks.add(trackId);
        _myPlaylists.value = playlists;
        storage.write(StringSAU.myPlaylistKeyStore, playlists.map((e) => e.toJson()).toList());
      }
    }
  }

  Future<void> getPlaylistTrack({required String playlistName}) async{
    try{
      List<String> trackIds = _myPlaylists.firstWhere((element) => element.name == playlistName).tracks;
      loadingTracks.value = true;
      final tracks = await _spotifyService.getSeveralTracks(trackIds: trackIds);
      loadingTracks.value = false;
      _myPlaylistTracks.value = tracks;
    }catch(e){
      loadingTracks.value = false;
      debugPrint('Error when get my playlist tracks: $e');
    }
  }

  @override
  void onInit() {
    List<dynamic> data = storage.read(StringSAU.myPlaylistKeyStore) ?? [];
    _myPlaylists.value = data.map((e) => MyPlaylist.fromJson(e)).toList();
    super.onInit();
  }

}
