import 'package:get_storage/get_storage.dart';

import '../../base/networking/services/auth_api.dart';
import '../api/user_info.dart';
import '../renew_token_info/renew_token_info.dart';


final _box = GetStorage();

class TokenManager {
  static const String _accessTokenKey = "access_token";
  static const String _refreshTokenKey = "refresh_token";
  static const String _tokenExpireTimeKey = 'kTokenExpireTime';
  static const String _userInfoKey = 'kUserInfoKey';
  static const String _walletPrivateKey = '_walletPrivateKey';
  static const String _walletPublicKey = '_walletPublicKey';

  static String walletPrivateKey() {
    return _box.read(_walletPrivateKey) ?? '';
  }

  static String walletPublicKey() {
    return _box.read(_walletPublicKey) ?? '';
  }

  static Future saveWalletPrivateKey(String key) async {
    return await _box.write(_walletPrivateKey, key);
  }

  static Future saveWalletPublicKey(String key) async {
    return await _box.write(_walletPublicKey, key);
  }

  static String accessToken() {
    return _box.read(_accessTokenKey) ?? '';
  }

  static String refreshToken() {
    return _box.read(_refreshTokenKey) ?? '';
  }

  static int? tokenExpireTimeStamp() {
    return _box.read<int>(_tokenExpireTimeKey);
  }

  static Future saveAccessToken(String token) async {
    return await _box.write(_accessTokenKey, token);
  }

  static Future saveRenewTokenInfo(RenewTokenInfo info) async {
    await _box.write(_accessTokenKey, info.accessToken);
    await _box.write(_refreshTokenKey, info.refreshToken);
    await _box.write(_tokenExpireTimeKey, info.accessTokenExpiresAt);
  }

  static Future saveTokenInfo(RenewTokenInfo info) async {
    await _box.write(_accessTokenKey, info.accessToken);
    await _box.write(_refreshTokenKey, info.refreshToken);
    await _box.write(_tokenExpireTimeKey, info.accessTokenExpiresAt);
  }

  static UserInfo? userInfo;

  static void saveUser(UserInfo? user) async {
    userInfo = user;
    if (user == null) {
      await _box.remove(_userInfoKey);
    } else {
      await _box.write(_userInfoKey, user.toJson());
    }
  }

  static bool isLoggedIn() {
    String token = accessToken();
    return token.isNotEmpty;
  }

  static void getCachedUserInfo() {
    var json = _box.read(_userInfoKey);
    userInfo = UserInfo.fromJson(json);
  }

  static final AuthAPI _api = AuthAPI();
  static void getNewUserInfo() async {
    try {
      UserInfo userInfo = await _api.getUserInfo();
      if (!userInfo.isActivated()) {
        // Get.offAllNamed(RouterName.activationCode);
      } else {
        TokenManager.saveUser(userInfo);
      }
    } catch (error) {
      // handleError(error);
    }
  }

  static void clearUserInfo() {
    // ContractManager.instance.removeWallet();
    saveAccessToken('');
    saveUser(null);
    userInfo = null;
  }
}
