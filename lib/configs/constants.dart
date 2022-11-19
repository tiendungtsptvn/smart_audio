enum Environment { staging, production }

Environment env = Environment.staging;

class Constants {
  /// APP CONFIG
  static const String appName = "-- FLUTTER BASE APP --";
  static const String baseUrl = "https://yourdomain.com/";

  static String defaultTaskId = "";
  static String defaultAlbumId = "";
  static String defaultCalendarEventId = "";

  static const double kLoadMoreOffset = 100;
  static const int perPageSize = 10;

  static const coin1AddressMain = "0xFD626E4c00B59AFCAFd0F47F743051A58BCc4A62";
  static const coin2AddressMain = "0xE904A243c4D697C12a5DcB96286Ac77F9ABD9628";

  static const coin1AddressTest = "0xA877Dbf99A7395DBd4624Ce30eA7DC5d329e1ec4";
  static const coin2AddressTest = "0x75b1051F9dc4De55570C3198b18Ecf2458d9Aa91";

  static String coin1Address =
      env == Environment.staging ? coin1AddressTest : coin1AddressMain;
  static String coin2Address =
      env == Environment.staging ? coin2AddressTest : coin2AddressMain;

  static const String agreementUrl =
      'https://docs.healthfi.app/term-and-conditions';
  static const String policyUrl = 'https://docs.healthfi.app/privacy-policy';
  static const String howToPlayUrl =
      'https://docs.healthfi.app/getting-started';
  static const String contactUrl = 'https://docs.healthfi.app/social-links';

  /// CUSTOM CONFIG APP
  static const String languageKey = 'LANGUAGE';

  static String apiDomain = 'https://staging-messenger.gapowork.vn/';

  static String requestEmailOTP = "auth/otp";
  static String loginWithOTP = "auth/login";
  static String loginWithPassword = "auth/login_by_password";
  static String renewTokenPath = "auth/otp";
  static String getUserInfo = "accounts/me";
  static String activateCode = "auth/activate";
  static String getCode = "auth/get_code";
  static String bindWallet = "accounts/bind_on_chain_wallet";
  static String newSession = "sessions/new";
  static String currentSession = "sessions/active_current";
  static String endSession = "sessions/end";
  static String sessionMetrics = "sessions/metrics";
  static String setPassword = "auth/password";

  static String getThreadsV3 = 'chat/v3.3/threads';
  static String loginV3 = 'auth/v3.0/login';

  static String searchMarket = "nft_market/search";
  static String buyNft = "nft_market/buy";
  static String sellNft = "nft_market/sell";
  static String openNft = "nft_inventory/open";

  static int maxOTPTime = 60;

  static int minPasswordLength = 6;

  static int maxLevel = 30;

  static const int restoreSnackDuration = 4;

  static int pageSizeThreads = 10;

  // Calories burned per minute = (MET x body weight in Kg x 3.5) ÷ 200
  // Detail here: https://captaincalculator.com/health/calorie/calories-burned-jumping-rope-calculator/

  static double getJumpingMet(double jpm) {
    if (jpm == 0) return 0;
    if (jpm < 100) {
      return 8.8 * jpm / 100;
    } else if (jpm < 120) {
      return 11.8;
    } else {
      return 12.3;
    }
  }
}
