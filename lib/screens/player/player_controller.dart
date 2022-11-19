import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:smart_audio/constants/constants.dart';
import 'package:smart_audio/utils/recommendation_track.dart';
import 'package:spotify/spotify.dart';
import '../../base/controller/base_controller.dart';

class PlayerController extends BaseController {
  /// Service of Spotify.
  SpotifyApi? spotifyApi;
  /// Player.
  final  _audioPlayer = AudioPlayer();


  ///______________________________///

  /// If it true: mini player is showing.
  final RxBool _miniShowing = false.obs;

  /// If it true: state is playing.
  final RxBool _playing = false.obs;

  /// The track, that player is handling.
  final Rx<Track> _currentTrack = Track().obs;

  /// Source of current playlist.
  final ConcatenatingAudioSource _listSourceTrack = ConcatenatingAudioSource(
    // Start loading next item just before reaching it
    useLazyPreparation: true,
    children: [],
  );

  /// Current playlist.
  final List<Track> _listTrack = [];

  /// Current playlist id.
  String _currentPlaylistId = '';

  /// If it true: current route is home tab, and mini player need padding from bottom.
  final RxBool _atHomeTab = true.obs;

  /// If it true: playlist is empty and autoplay is off.
  bool _singlePlay = true;

  /// If it true: current track is saved to storage.
  bool _savedCurrentTracks = false;

  /// Center position of current track.
  ///
  /// Need for handle when we save track information to storage
  Duration? _centerPosition;

  ///______________________________///

  bool get miniShowing => _miniShowing.value;

  bool get playing => _playing.value;

  Track get currentTrack => _currentTrack.value;


  bool get atHomeTab => _atHomeTab.value;

  /// Show mini player.
  void showMiniPlayer() {
    if (_miniShowing.isFalse) {
      debugPrint("\nShow mini player\n");
      _miniShowing.value = true;
    }
  }
  /// Hide mini player.
  void hideMiniPlayer({bool? pause}) {
    if (_miniShowing.isTrue) {
      debugPrint("\nHide mini player\n");
      _miniShowing.value = false;
    }
    if(pause != null && pause && _playing.value){
      _audioPlayer.pause();
      _playing.value = false;
    }
  }

  /// Play single track.
  void playTrack({required Track track})async{
    if(track.previewUrl != null){
      _singlePlay = true;
      _miniShowing.value = true;
      await _audioPlayer.setUrl(track.previewUrl!);
      _audioPlayer.play();
      _currentTrack.value = track;
    }else{
      debugPrint("Preview url of track is null");
    }
  }

  /// Play a playlist.
  void playListTrack({required List<Track> listTrack, required int index, required String? playListId,})async{
    if(playListId != null){
      _singlePlay = false;
      if(playListId != _currentPlaylistId){
        _currentPlaylistId = playListId;
        List<AudioSource> sources = listTrack.map((e) => AudioSource.uri(Uri.parse(e.previewUrl!))).toList();
        await _listSourceTrack.addAll(sources);
        _listTrack.clear();
        _listTrack.addAll(listTrack);
      }
      await _audioPlayer.setAudioSource(_listSourceTrack, initialIndex: index, initialPosition: Duration.zero);
      _miniShowing.value = true;
      _audioPlayer.play();
    }
  }

  /// Play or pause.
  void pauseOrResume() async{
    if(_audioPlayer.playing){
      _audioPlayer.pause();
    }else{
      if(_audioPlayer.duration != null){
        if(_audioPlayer.position.compareTo(_audioPlayer.duration!) >= 0){
          await _audioPlayer.seek(Duration.zero);
        }
      }
      _audioPlayer.play();
    }
  }

  /// Create spotify service.
  void createSpotifyApi(bool isAnonymous, {String? accessToken}) {
    if (isAnonymous) {
      spotifyApi = SpotifyApi(
        SpotifyApiCredentials(
          spotifyClientId,
          spotifyClientSecret,
        ),
      );
    } else {
      if (accessToken == null) {
        debugPrint("Access token is required (Player controller.dart)");
      } else {
        spotifyApi = SpotifyApi.withAccessToken(accessToken);
      }
    }
  }

  /// Handle when route change.
  void changeRoute({required bool atTabScreen}){
    if(atTabScreen && !_atHomeTab.value){
      _atHomeTab.value = true;
    }
    if(!atTabScreen && _atHomeTab.value){
      _atHomeTab.value = false;
    }
  }

  @override
  void onInit() {

    /// Handle play state.
    _audioPlayer.playerStateStream.listen((playerState) {
      if (playerState.processingState == ProcessingState.completed) {
        print("completed");
        if(_singlePlay){
          _audioPlayer.pause();
        }
        _playing.value = false;
      }
    });

    /// Handle play state too.
    _audioPlayer.playingStream.listen((event) {
      if(event){
          print("playing");
          _playing.value = true;
      }else{
        _playing.value = false;
        print("Not playing");
      }
    });

    ///Listen index to set current track.
    ///
    _audioPlayer.currentIndexStream.listen((event) {
      if(!_singlePlay && event != null){
        print("This audio index $event");
        _currentTrack.value = _listTrack[event];
        _savedCurrentTracks = false;
      }
    });
    /// Store information of track.
    ///
    /// Store when player play half of the current track.
    _audioPlayer.positionStream.listen((event) {
      if(_audioPlayer.duration != null && !_savedCurrentTracks){
        _centerPosition = Duration(seconds: (_audioPlayer.duration!.inSeconds / 2).round());
        if(event.compareTo(_centerPosition!) >= 0){
          debugPrint("\nStore information of ${_currentTrack.value.name}\n");
          storeTrackInformation(track: _currentTrack.value);
          _savedCurrentTracks = true;
        }
      }
    });


    super.onInit();
  }
}
