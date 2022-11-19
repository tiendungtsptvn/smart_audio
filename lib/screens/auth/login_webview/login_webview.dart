import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:smart_audio/base/networking/services/auth_api.dart';
import 'package:smart_audio/routes/router_name.dart';

import '../auth_controller.dart';


class LoginWebViewScreen extends StatelessWidget {
  const LoginWebViewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthController authController = Get.find<AuthController>();
    return Scaffold(
      body: SafeArea(
        child: InAppWebView(
          initialOptions: InAppWebViewGroupOptions(
            crossPlatform: InAppWebViewOptions(
              userAgent:
              "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/105.0.0.0 afari/537.36",
            ),
          ),
          initialUrlRequest: URLRequest(
            url: Uri.parse("https://accounts.spotify.com/"),
          ),
          androidOnPermissionRequest: (controller, origin, resources) async {
            return PermissionRequestResponse(
              resources: resources,
              action: PermissionRequestResponseAction.GRANT,
            );
          },
          onLoadStop: (controller, action) async {
            if (action == null) return;
            String url = action.toString();
            if (url.endsWith("/")) {
              url = url.substring(0, url.length - 1);
            }

            final exp = RegExp(r"https:\/\/accounts.spotify.com\/\w+\/status");

            if (exp.hasMatch(url)) {
              final cookies =
              await CookieManager.instance().getCookies(url: action);
              final cookieHeader =
              cookies.fold<String>("", (previousValue, element) {
                if (element.name == "sp_dc" || element.name == "sp_key") {
                  return "$previousValue; ${element.name}=${element.value}";
                }
                return previousValue;
              });

              final body = await AuthAPI.getAccessToken(cookieHeader);
              authController.setAuthState(
                accessToken: body.accessToken,
                authCookie: cookieHeader,
                expiration: body.expiration,
              );
              await Future.delayed(const Duration(seconds: 1));
              Get.toNamed(RouterName.tabs);
            }
          },
        ),
      ),
    );
  }
}
