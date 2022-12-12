import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_audio/screens/home/home_controller.dart';
import 'package:smart_audio/screens/home/widgets/kpop_playlists.dart';
import 'package:smart_audio/screens/home/widgets/top_hit_playlists.dart';
import 'package:smart_audio/screens/home/widgets/vietnam_playlists.dart';
import './widgets/featured_playlists.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children:  [
          // Feature play list.
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Text(
              "Featured",
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
            ),
          ),
          const FeaturedPlaylists(),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Text(
              "Top Hits",
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
            ),
          ),
          const TopHitPlaylists(),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Text(
              "Spotify Singles",
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
            ),
          ),
          const VietnamPlaylists(),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Text(
              "K-Pop",
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
            ),
          ),
          const KPopPlaylists(),
          ElevatedButton(
            onPressed: () {
              Get.find<HomeController>().testApi();
            },
            child: const Text("Test api"),
          ),
        ],
      ),
    );
  }
}
