import 'package:get/get.dart';
import 'package:smart_audio/screens/auth/login_webview/login_webview.dart';
import 'package:smart_audio/screens/playlist/playlist_screen.dart';
import 'package:smart_audio/screens/splash/splash_screen.dart';
import 'package:smart_audio/screens/tabs/tabs_screen.dart';
import '../screens/change_password/change_password_screen.dart';
import '../screens/chats/chats_screen.dart';
import '../screens/chats/stored_conversation/stored_conversation_screen.dart';
import '../screens/loading/loading_screen.dart';
import '../screens/login/account_login_screen.dart';
import '../screens/login/login_screen.dart';
import 'router_name.dart';

class Pages {
  static List<GetPage> pages = [
    GetPage(name: RouterName.loading, transitionDuration: Duration.zero, page: () => LoadingScreen()),
    GetPage(name: RouterName.login, page: () => const LoginScreen(), binding: LoginScreenBinding()),
    GetPage(
        name: RouterName.accountLogin, page: () => const AccountLoginScreen(), binding: AccountLoginScreenBinding()),
    GetPage(
        name: RouterName.changePassword,
        page: () => const ChangePasswordScreen(),
        binding: ChangePasswordScreenBinding()),
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
      page: () => TabsScreen(),
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

  ];
}
