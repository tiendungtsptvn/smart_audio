import 'package:get/get.dart';
import 'package:smart_audio/screens/auth/login_webview/login_webview.dart';
import 'package:smart_audio/screens/player/player_screen.dart';
import 'package:smart_audio/screens/playlist/playlist_screen.dart';
import 'package:smart_audio/screens/search/search_screen.dart';
import 'package:smart_audio/screens/tabs/tabs_screen.dart';
import 'package:smart_audio/screens/wishlist_tracks/wishlist_screen.dart';
import '../screens/chats/chats_screen.dart';
import '../screens/chats/stored_conversation/stored_conversation_screen.dart';

import 'router_name.dart';

class Pages {
  static List<GetPage> pages = [
    GetPage(
      name: RouterName.chats,
      page: () => const ChatsScreen(),
      binding: ChatsScreenBinding(),
    ),
    GetPage(
      name: RouterName.storedConversation,
      page: () => const StoredConversation(),
      binding: StoredConversationBinding(),
    ),
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

  ];
}
