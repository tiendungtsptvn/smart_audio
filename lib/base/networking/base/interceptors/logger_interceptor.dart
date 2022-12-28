import 'dart:convert';

import 'package:dio/dio.dart';


class LoggerInterceptor extends Interceptor {
  /// Width size per logPrint
  final int maxWidth = 90;

  final bool responseBody;

  /// to detect print function

  LoggerInterceptor({
    this.responseBody = true,
  });

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    _printLine('╔', '╗');
    _printLine('╚');
    handler.next(options);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    _printLine('╔', '╗');
    _printLine('╚');
    handler.next(err);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    _printLine('╔', '╗');
    final responseHeaders = <String, String>{};
    response.headers.forEach((k, list) => responseHeaders[k] = list.toString());
    _printLine('╚');
    handler.next(response);
  }

  String _cURLRepresentation(RequestOptions options) {
    List<String> components = ["\$ curl -i"];
    components.add("-X ${options.method}");

    options.headers.forEach((k, v) {
      if (k != "Cookie") {
        components.add("-H \"$k: $v\"");
      }
    });

    if (options.method.toUpperCase() != "GET") {
      try {
        var data = json.encode(options.data);
        data = data.replaceAll('"', '\\"');
        components.add("-d \"$data\"");
      } catch (_) {}
    }

    components.add("\"${options.uri.toString()}\"");

    return components.join('\\\n\t');
  }

  void _printLine([String pre = '', String suf = '╝']) {
  }
}
