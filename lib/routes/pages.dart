import 'package:get/get.dart';
import 'package:smart_audio/screens/auth/login_webview/login_webview.dart';
import 'package:smart_audio/screens/my_playlist/my_playlist_screen.dart';
import 'package:smart_audio/screens/my_playlist/playlist_track_screen.dart';
import 'package:smart_audio/screens/player/player_screen.dart';
import 'package:smart_audio/screens/playlist/playlist_screen.dart';
import 'package:smart_audio/screens/search/search_screen.dart';
import 'package:smart_audio/screens/tabs/tabs_screen.dart';
import 'package:smart_audio/screens/wishlist_tracks/wishlist_screen.dart';

import 'router_name.dart';

class Pages {
  static List<GetPage> pages = [
    GetPage(
      name: RouterName.tabs,
      page: () => const TabsScreen(),
      binding: TabsScreenBinding(),
    ),
    GetPage(
      name: RouterName.loginWebView,
      page: () => const LoginWebViewScreen(),
    ),
    GetPage(
      name: RouterName.playlist,
      page: () => const PlaylistScreen(),
      binding: PlaylistScreenBinding()
    ),
    GetPage(
        name: RouterName.search,
        page: () => const SearchScreen(),
    ),
    GetPage(
      name: RouterName.wishlist,
      page: () => const WishlistScreen(),
    ),
    GetPage(
      name: RouterName.playerScreen,
      page: () => const PlayerScreen(),
      transition: Transition.downToUp,
    ),
    GetPage(
      name: RouterName.myPlaylistScreen,
      page: () => const MyPlaylistScreen(),
    ),
    GetPage(
        name: RouterName.myPlaylistTrackScreen,
        page: () => const MyPlaylistTrackScreen(),
        binding: MyPlaylistTrackScreenBinding()
    ),
  ];
}
