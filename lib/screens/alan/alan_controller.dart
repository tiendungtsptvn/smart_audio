
import 'dart:async';

import 'package:alan_voice/alan_voice.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:smart_audio/screens/player/player_controller.dart';
import 'package:smart_audio/utils/recommendation_track.dart';
import 'package:spotify/spotify.dart';
import '../../base/controller/base_controller.dart';
import '../../base/networking/services/spotify_api.dart';
import '../playlist/recommendation_playlist.dart';

class AlanController extends BaseController {

  final PlayerController playerController;

  AlanController({required this.playerController});

  final storage = GetStorage();

  final SpotifyService _spotifyService = SpotifyService(
    spotifyApi: Get.find<PlayerController>().spotifyApi!,
  );

  Timer? _debounceAction;

  /// Handle action data and do it.
  void action({required Map<String, dynamic> actionData}) async{
    if (_debounceAction?.isActive ?? false) {
      _debounceAction?.cancel();
    }
    _debounceAction = Timer(const Duration(seconds: 1), () async{
      Map<String, dynamic> actions = actionData['action'] ?? {};
      for(var key in actions.keys){
        switch(key){
          case 'play':
            String? keyword = actions[key]['value'];
            if(keyword == null || keyword == ''){
              if(playerController.currentTrack.id != null){
                await Future.delayed(const Duration(milliseconds: 500));
                AlanVoice.deactivate();
                playerController.pauseOrResume();
              }else{
                AlanVoice.playText('What song do you want to listen to?');
              }
            }else{
              AlanVoice.playText('Ok $keyword will be play');
              await Future.delayed(const Duration(seconds: 3));
              Track? searchedTrack = await _searchATrack(keyword: keyword);
              if(searchedTrack != null){
                AlanVoice.deactivate();
                _playTrack(searchedTrack);
              }
            }
            break;
          case 'recommend':
            _recommendATrack();
            break;
        }
      }
    });
  }

  Future<Track?> _searchATrack({required String keyword}) async{
    String query = keyword.trim();
    if(query.isNotEmpty){
      try{
        debugPrint("Alan searching...");
        List<Track> tracks = await _spotifyService.searchTracks(keyword: query);
        return tracks.first;
      }catch(_){
        debugPrint("Error when search track(Alan controller)");
        rethrow;
      }
    }
    return null;
  }

  Future<void> _recommendATrack() async{
    List<String> seedTracks = getSeedData(storage: storage, tracks: true,);
    List<String> seedArtists = getSeedData(storage: storage, artists: true,);
    List<String> seedGenres = getSeedData(storage: storage, genres: true,);

    try{
      debugPrint("Alan recommend...");
      List<TrackSimple> tracks = await _spotifyService.getRecommendationTracks(
        seedTracks: seedTracks,
        seedGenres: seedGenres,
        seedArtists: seedArtists,
      );
      await Future.delayed(const Duration(seconds: 2));
      AlanVoice.playText('Here are a few songs i recommend for you');
      Get.to(() => RecommendationPlaylist(tracks: tracks,));
    }catch(e){
      debugPrint("Error when recommend track(Alan controller) $e");
      rethrow;
    }
  }

  void _playTrack(Track track){
    playerController.playTrack(track: track);
  }

  void _stopPlaying(){
    playerController.pauseOrResume();
  }

  @override
  void onClose() {
    _debounceAction?.cancel();
    super.onClose();
  }


}

