
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:smart_audio/utils/string_utils.dart';

import '../../../configs/constants.dart';
import '../../../models/api/code_response.dart';
import '../../../models/api/login_response.dart';
import '../../../models/api/request_email_response.dart';
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

  Future<bool> requestEmailOTP(String email) async {
    try {
      final response = await _service.postData(
          endPoint: Constants.requestEmailOTP, body: {"email_address": email},);
      ApiResponse<RequestEmailResponse> result =
          ApiResponse<RequestEmailResponse>.fromJson(response.data);
      return result.data.status >= 0;
    } catch (e) {
      rethrow;
    }
  }

  Future<LoginResponse> loginWithOtp(String email, String otp) async {
    try {
      final response = await _service.postData(
          endPoint: Constants.loginWithOTP,
          body: {"email_address": email, "otp": otp});
      ApiResponse<LoginResponse> result =
          ApiResponse<LoginResponse>.fromJson(response.data);
      return result.data;
    } catch (e) {
      rethrow;
    }
  }

  Future<LoginResponse> loginWithPassword(String email, String password) async {
    try {
      String hashedPassword = password.hashSha256();
      final response = await _service.postData(
          endPoint: Constants.loginWithPassword,
          body: {"email_address": email, "password_hashed": hashedPassword});
      ApiResponse<LoginResponse> result =
          ApiResponse<LoginResponse>.fromJson(response.data);
      return result.data;
    } catch (e) {
      rethrow;
    }
  }

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

  Future<LoginResponse> activateCode(String code) async {
    try {
      final response = await _service
          .postData(endPoint: Constants.activateCode, body: {"code": code});
      ApiResponse<LoginResponse> result =
          ApiResponse<LoginResponse>.fromJson(response.data);
      return result.data;
    } catch (e) {
      rethrow;
    }
  }

  Future<CodeResponse> getCode(String refId) async {
    try {
      final response = await _service
          .getData(endPoint: Constants.getCode, query: {"ref_id": refId});
      ApiResponse<CodeResponse> result =
          ApiResponse<CodeResponse>.fromJson(response.data);
      return result.data;
    } catch (e) {
      rethrow;
    }
  }

  Future<UserInfo> bindOnChainWallet(String address, String? otp) async {
    var params = {"on_chain_wallet": address};
    if (otp != null) {
      params["otp"] = otp;
    }
    try {
      final response =
          await _service.postData(endPoint: Constants.bindWallet, body: params);
      ApiResponse<UserInfo> result =
          ApiResponse<UserInfo>.fromJson(response.data);
      return result.data;
    } catch (e) {
      rethrow;
    }
  }

  Future<LoginResponse> setPassword(String password, String otp) async {
    var hashedPass = password.hashSha256();
    var params = {"password_hashed": hashedPass, "otp": otp};
    try {
      final response = await _service.postData(
          endPoint: Constants.setPassword, body: params);
      ApiResponse<LoginResponse> result =
          ApiResponse<LoginResponse>.fromJson(response.data);
      return result.data;
    } catch (e) {
      rethrow;
    }
  }

  Future<LoginResponse> changePassword(
      String oldPassword, String newPassword, String otp) async {
    var oldHashedPass = oldPassword.hashSha256();
    var newHashedPass = newPassword.hashSha256();
    var params = {
      "old_password_hashed": oldHashedPass,
      "new_password_hashed": newHashedPass,
      "otp": otp
    };
    try {
      final response = await _service.patchData(
          endPoint: Constants.setPassword, body: params);
      ApiResponse<LoginResponse> result =
          ApiResponse<LoginResponse>.fromJson(response.data);
      return result.data;
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> login()async{
    var params = {
      "client_id": "6n6rwo86qmx7u8aahgrq",
      "device_model": "Simulator iPhone 11",
      "device_id": "76cce865cbad4d02",
      "password": "4bff60a3797bc8053cd40253218c93afa7962fb966d012c844e254ad7788147e",
      "trusted_device": true,
      "email": "nguyenmanhtoan@gapo.com.vn"
    };
    // _service.requestOptions.headers?.addAll({
    //   "content-type": "application/json; charset=utf-8",
    //   "x-gapo-workspace-id": "581860791816317",
    //   "x-gapo-lang": "vi"
    // });
    try {
      final res = await _service.postData(
          endPoint: Constants.loginV3, body: params);
      return res.data;
    } catch (e) {
      rethrow;
    }
  }
}
