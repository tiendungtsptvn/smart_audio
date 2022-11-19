import 'package:dio/dio.dart';

import '../../../../models/token/token_manager.dart';
import '../../../../utils/utils.dart';


class AuthenticationInterceptor extends Interceptor {
  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) {
    String token = TokenManager.accessToken();
    Map<String, String> headers = {
      'Authorization': 'Bearer $token',
      'x-language': Utils.currentLanguageCode()
    };
    options.headers.addAll(headers);

    handler.next(options);
  }
}
