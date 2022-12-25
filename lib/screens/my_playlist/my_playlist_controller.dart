
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:smart_audio/constants/constants.dart';
import 'package:smart_audio/models/local/my_playlist.dart';
import 'package:smart_audio/routes/router_name.dart';
import '../../base/controller/base_controller.dart';

class MyPlaylistController extends BaseController {

  final storage = GetStorage();

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

      Get.showSnackbar(const GetSnackBar(
        message: 'Added !',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: ColorSAU.secondaryColor,
        duration: Duration(seconds: 1),
      ));
    }
  }

  void goToMyPlaylistScreen({required MyPlaylist playlist}) {
    Get.toNamed(
      RouterName.myPlaylistTrackScreen,
      arguments: {
        'track_id': playlist.tracks,
        'playlist_name': playlist.name,
      },
    );
  }


  @override
  void onInit() {
    List<dynamic> data = storage.read(StringSAU.myPlaylistKeyStore) ?? [];
    _myPlaylists.value = data.map((e) => MyPlaylist.fromJson(e)).toList();
    super.onInit();
  }

}
