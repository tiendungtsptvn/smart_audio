import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:spotify/spotify.dart';
import '../../base/controller/base_controller.dart';
import '../../base/networking/services/spotify_api.dart';
import '../player/player_controller.dart';

class SearchController extends BaseController {
  final SpotifyService _spotifyService = SpotifyService(
    spotifyApi: Get.find<PlayerController>().spotifyApi!,
  );

  Timer? _debounceSearch;

  final RxList<Track> _searchedTracks = <Track>[].obs;

  final RxBool _searching = false.obs;

  final TextEditingController searchController = TextEditingController();

  String currentKeyword = '';

  List<Track> get searchedTracks => _searchedTracks;

  bool get searching => _searching.value;



  Future<void> searchTracks({required String keyword}) async{
    String query = keyword.trim();
    if(query.isNotEmpty && query != currentKeyword){
      currentKeyword = query;
      _searching.value = true;
      if (_debounceSearch?.isActive ?? false) {
        _debounceSearch?.cancel();
      }
      _debounceSearch = Timer(const Duration(seconds: 1), () async{
        try{
          debugPrint("Searching...");
          List<Track> tracks = await _spotifyService.searchTracks(keyword: query);
          _searchedTracks.value = tracks;
          _searching.value = false;
        }catch(_){
          _searching.value = false;
          debugPrint("Error when search track(search controller)");
        }
      });
    }else if(query.isEmpty){
      currentKeyword = query;
      _searchedTracks.value = [];
    }
  }

  void clearData(){
    searchController.clear();
    currentKeyword = '';
    _searchedTracks.value = [];
  }

  @override
  void onClose() {
    if (_debounceSearch != null) {
      _debounceSearch!.cancel();
    }
    searchController.dispose();
    super.onClose();
  }
}
