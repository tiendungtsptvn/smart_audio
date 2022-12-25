import 'package:flutter/material.dart';
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
        children:  const [
          // Feature play list.
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Text(
              "Featured",
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
            ),
          ),
          FeaturedPlaylists(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Text(
              "Top Hits",
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
            ),
          ),
          TopHitPlaylists(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Text(
              "Spotify Singles",
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
            ),
          ),
          VietnamPlaylists(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Text(
              "K-Pop",
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
            ),
          ),
          KPopPlaylists(),
        ],
      ),
    );
  }
}
