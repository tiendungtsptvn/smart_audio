import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:smart_audio/screens/alan/alan_controller.dart';
import 'package:smart_audio/screens/player/mini_player.dart';
import 'package:smart_audio/screens/player/player_controller.dart';
import 'package:smart_audio/screens/wishlist_tracks/wishlist_controller.dart';
import 'package:smart_audio/theme/themes.dart';
import 'package:smart_audio/utils/recommendation_track.dart';
import 'package:smart_audio/utils/utils.dart';

import 'generated/locales.g.dart';
import 'models/token/token_manager.dart';
import 'routes/routes.dart';

void main() async {
  await GetStorage.init();
  loadCache();
  sortAndRemoveRecommendationInformation();
  runApp(const MyApp());
}

void loadCache() {
  if (TokenManager.isLoggedIn()) {
    TokenManager.getCachedUserInfo();
    TokenManager.getNewUserInfo();
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PlayerController playerController = Get.put(PlayerController());
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppThemes.theme(),
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            RefreshConfiguration(
              hideFooterWhenNotFull: true,
              child: GetMaterialApp(
                theme: AppThemes.theme(),
                darkTheme: AppThemes.darktheme(),
                themeMode: AppThemes().init(),
                locale: const Locale("en"),
                fallbackLocale: const Locale("en"),
                supportedLocales: const [
                  Locale('vi'),
                  Locale('en'),
                ],
                // `localizationsDelegates` transfer locale to child widgets, suchas datetime picker
                localizationsDelegates: const [
                  GlobalMaterialLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                translationsKeys: AppTranslation.translations,
                initialRoute: RouterName.tabs,
                debugShowCheckedModeBanner: false,
                getPages: Pages.pages,
                routingCallback: (value) {
                  if (value == null || value.isBottomSheet == true || value.isDialog == true) return;
                  Utils.trackScreen(value.current);
                  if(value.route?.settings.name == RouterName.tabs){
                    playerController.changeRoute(atTabScreen: true);
                  }else{
                    playerController.changeRoute(atTabScreen: false);
                  }
                },
                builder: EasyLoading.init(),
              ),
            ),
            const Align(
              alignment: Alignment.bottomCenter,
              child: MiniPlayerScreen(),
            )
          ],
        ),
      ),
    );
  }
}
