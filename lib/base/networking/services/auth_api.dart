
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import '../../../configs/constants.dart';
import '../../../models/api/smart_audio_credential.dart';
import '../../../models/api/user_info.dart';
import '../../../models/base/api_response.dart';
import '../base/api.dart';

class AuthAPI {
  static final Dio _dio = Dio();
  static Future<SmartAudioCredential> getAccessToken(
      String cookieHeader) async {
    try {
      final res = await _dio.get(
        "https://open.spotify.com/get_access_token?reason=transport&productType=web_player",
        options: Options(
            headers: {
              "Cookie": cookieHeader,
              "User-Agent":
              "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/105.0.0.0 Safari/537.36"
            }
        ),
      );
      return SmartAudioCredential.fromJson(
        res.data,
      );
    } catch (e) {
      debugPrint("Get Access Token Error\n$e\n");
      rethrow;
    }
  }

final ApiService _service = ApiService("https://staging-api.gapowork.vn/");

  Future<UserInfo> getUserInfo() async {
    try {
      final response = await _service.getData(endPoint: Constants.getUserInfo);
      ApiResponse<UserInfo> result =
          ApiResponse<UserInfo>.fromJson(response.data);
      return result.data;
    } catch (e) {
      rethrow;
    }
  }
}
