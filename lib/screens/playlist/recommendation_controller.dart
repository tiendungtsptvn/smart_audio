import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:smart_audio/base/networking/services/spotify_api.dart';
import 'package:smart_audio/screens/player/player_controller.dart';
import 'package:spotify/spotify.dart';
import '../../base/controller/base_controller.dart';

class RecommendationController extends BaseController {
  final SpotifyService _spotifyService = SpotifyService(
    spotifyApi: Get.find<PlayerController>().spotifyApi!,
  );


  final RxBool _collapse = true.obs;

  ScrollController scrollController = ScrollController();


  bool get collapse => _collapse.value;

  @override
  void onInit() async{

    if (Get.find<PlayerController>().spotifyApi == null) {
      debugPrint("SpotifyApi null at home controller");
    }

    scrollController.addListener(() {
      if (scrollController.position.pixels >= 160 && _collapse.value) {
        _collapse.value = false;
      } else if (scrollController.position.pixels < 160 && !_collapse.value) {
        _collapse.value = true;
      }
    });

    super.onInit();
  }
}
