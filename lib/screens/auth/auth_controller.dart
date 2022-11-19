import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:smart_audio/base/networking/services/auth_api.dart';
import '../../base/controller/base_controller.dart';
import '../../routes/router_name.dart';

class AuthController extends BaseController {


  static const String _accessTokenKey = "access_token";
  static const String _refreshTokenKey = "refresh_token";
  static const String _authCookieKey = 'auth_cookie';
  static const String _tokenExpireTimeKey = 'kTokenExpireTime';
  static const String _userInfoKey = 'kUserInfoKey';
  static const String _walletPrivateKey = '_walletPrivateKey';
  static const String _walletPublicKey = '_walletPublicKey';

  final storage = GetStorage();

  // final ChatAPI _chatAPI = ChatAPI();

  final RxBool _initializing = true.obs;
  bool get initializing => _initializing.value;

  final RxInt _count = 0.obs;
  int get count => _count.value;
  void addCount(){
    _count.value = _count.value + 1;
  }

  String? _accessToken;
  String? get accessToken => _accessToken;

  String? _authCookie;
  String? get authCookie => _authCookie;

  DateTime? _expiration;
  DateTime? get expiration => _expiration;

  Timer? _refresher;

  bool get isLoggedIn => !isAnonymous && _expiration != null;

  bool get isAnonymous => accessToken == null && authCookie == null;

  bool get isExpired =>
      _expiration != null && _expiration!.isBefore(DateTime.now());

  Duration get expiresIn =>
      _expiration?.difference(DateTime.now()) ?? Duration.zero;

  @override
  void onReady(){
    super.onReady();
    initialize();
  }


  void initialize() async{
    _createRefresher();
    getAccessTokenFromStorage();
    getAuthCookieFromStorage();
    await Future.delayed(const Duration(seconds: 1));
    _initializing.value = false;
  }

  void getAccessTokenFromStorage(){
    String? token = storage.read(_accessTokenKey);
    _accessToken = token;
    debugPrint("\n Get access token storage\n$_accessToken\n");
  }

  void getAuthCookieFromStorage(){
    String? authCookie = storage.read(_authCookieKey);
    _authCookie = authCookie;
    debugPrint("\n Get auth cookie storage\n$_authCookie\n");
  }

  refreshAuth() async {
    final data = await AuthAPI.getAccessToken(authCookie!);
    _accessToken = data.accessToken;
    _expiration = data.expiration;
    _restartRefresher();
  }

  Timer? _createRefresher() {
    if (expiration == null || !isExpired || authCookie == null) {
      return null;
    }
    _refresher?.cancel();
    return Timer(expiresIn, refreshAuth);
  }

  void _restartRefresher() {
    _refresher?.cancel();
    _refresher = _createRefresher();
  }

  void setAuthState({
    bool safe = true,
    String? accessToken,
    DateTime? expiration,
    String? authCookie,
  }) {
    if (safe) {
      if (accessToken != null) _accessToken = accessToken;
      if (expiration != null) {
        _expiration = expiration;
        _restartRefresher();
      }
      if (authCookie != null) _authCookie = authCookie;
    } else {
      _accessToken = accessToken;
      _expiration = expiration;
      _authCookie = authCookie;

      _restartRefresher();
    }
    /// Todo: save token to storage.
    // updatePersistence();
  }

}
