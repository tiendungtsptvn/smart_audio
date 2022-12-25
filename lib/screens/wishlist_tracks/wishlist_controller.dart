
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:smart_audio/base/networking/services/spotify_api.dart';
import 'package:smart_audio/constants/constants.dart';
import 'package:smart_audio/screens/player/player_controller.dart';
import 'package:spotify/spotify.dart';
import '../../base/controller/base_controller.dart';

class WishlistController extends BaseController {
  final SpotifyService _spotifyService = SpotifyService(
    spotifyApi: Get.find<PlayerController>().spotifyApi!,
  );

  final storage = GetStorage();

  final RxList<Track> _wishlistTracks = <Track>[].obs;

  final RxBool loadingTracks = false.obs;

  List<Track> get wishlistTracks => _wishlistTracks;

  final RxList<String> _currentWishlist = <String>[].obs;

  List<String> get currentWishlist => _currentWishlist;

  void addToWishlist(String? trackId){
   if(trackId != null){
     List<String> wishlist = [..._currentWishlist];
     if(!wishlist.contains(trackId)){
       wishlist.add(trackId);
       _currentWishlist.value = wishlist;
       storage.write(StringSAU.wishlistTracksKeyStore, wishlist);
     }
   }
  }

  void removeFromWishlist(String? trackId){
    if(trackId != null){
      List<String> wishlist = [..._currentWishlist];
      if(wishlist.contains(trackId)){
        wishlist.removeWhere((element) => element == trackId);
        _currentWishlist.value = wishlist;
        storage.write(StringSAU.wishlistTracksKeyStore, wishlist);
        List<Track> newList = [..._wishlistTracks];
        newList.removeWhere((element) => element.id == trackId);
        _wishlistTracks.value = newList;
      }
    }
  }

  Future<void> getWishlist() async{
    try{
      loadingTracks.value = true;
      final tracks = await _spotifyService.getSeveralTracks(trackIds: currentWishlist);
      loadingTracks.value = false;
      _wishlistTracks.value = tracks;
    }catch(e){
      loadingTracks.value = false;
      debugPrint('Error when get wish list: $e');
    }
  }

  @override
  void onInit() {
    List<dynamic> data = storage.read(StringSAU.wishlistTracksKeyStore) ?? [];
    _currentWishlist.value = data.map((e) => e.toString()).toList();
    super.onInit();
  }

}
