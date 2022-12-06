import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:smart_audio/utils/popup.dart';
import 'package:smart_audio/utils/text_element.dart';

import '../base/networking/base/app_exception.dart';
import '../generated/locales.g.dart';
import '../routes/router_name.dart';
import '../widgets/alert_dialog.dart';
import 'analytics.dart';
import 'local_service.dart';
import 'log.dart';

const String _languageKey = "language_key";
const String _soundKey = "sound_key";

class Utils {
  Utils._();

  static String currentLanguage() {
    String languageCode = LocalService.get(_languageKey, false);
    switch (languageCode) {
      case "en":
        return LocaleKeys.account_languageEnglish.tr;
      case "vi":
        return LocaleKeys.account_languageVietnamese.tr;
      case "zh":
        return LocaleKeys.account_languageChinese.tr;
      default:
        return LocaleKeys.account_languageEnglish.tr;
    }
  }

  static String currentLanguageCode() {
    String languageCode = LocalService.get(_languageKey, false) ?? "en";
    return languageCode;
  }

  static void saveLanguage(String code) {
    LocalService.save(_languageKey, code, false);
    Get.updateLocale(Locale(code));
  }

  static void setSound(bool on) {
    LocalService.save(_soundKey, on, false);
  }

  static bool getSoundConfig() {
    return LocalService.get(_soundKey, false) ?? true;
  }

  static Future<String> getDeviceId() async {
    return 'deviceId';
  }

  static String imageThumb(String pattern, String size) {
    // ignore: unnecessary_null_comparison
    if (pattern == null || pattern.isEmpty) return "";

    String url = pattern.replaceAll("\$size\$", size);
    return url;
  }

  static bool isValidUrl(String? url) {
    url ??= "";
    return Uri.tryParse(url)?.hasAbsolutePath ?? false;
  }

  static String pluralizeMany(String string, num number) {
    int count = number.round();
    if (count == 0) {
      return "${string}_zero".tr.replaceFirst("%", count.toString());
    } else if (count == 1) {
      return "${string}_one".tr.replaceFirst("%", count.toString());
    }
    return "${string}_many".tr.replaceFirst("%", count.toString());
  }

  static String timeAgoString(int time) {
    num now = DateTime.now().millisecondsSinceEpoch;
    num elapsed = max(0, now - time);

    final num seconds = elapsed / 1000;
    final num minutes = seconds / 60;
    final num hours = minutes / 60;
    final num days = hours / 24;
    final num months = days / 30;
    final num years = days / 365;

    if (years >= 1) {
      return pluralizeMany("time_years_ago", years);
    }
    if (months >= 1) {
      return pluralizeMany("time_months_ago", months);
    }
    if (days >= 1) {
      return pluralizeMany("time_days_ago", days);
    }
    if (hours >= 1) {
      return pluralizeMany("time_hours_ago", hours);
    }
    if (minutes >= 1) {
      return pluralizeMany("time_minutes_ago", minutes);
    }
    return LocaleKeys.time_just_now.tr;
  }

  static TextElementType? textElementType(String text) {
    if (TextElementType.hashtag.regex.hasMatch(text)) {
      return TextElementType.hashtag;
    }
    if (TextElementType.url.regex.hasMatch(text)) {
      return TextElementType.url;
    }
    if (TextElementType.phonenumber.regex.hasMatch(text)) {
      return TextElementType.phonenumber;
    }
    if (TextElementType.tag.regex.hasMatch(text)) {
      return TextElementType.tag;
    }
    return null;
  }

  /// to display file size in MB, KB, GB, etc.
  static String readableFileSize({required int bytes}) {
    var kb = bytes / 1024;
    if (kb < 0.1) {
      return '$bytes bytes';
    }
    var mb = kb / 1024;
    if (mb < 0.1) {
      return '${kb.toStringAsFixed(2)} KB';
    }
    return '${mb.toStringAsFixed(2)} MB';
  }

  static double getBottomSheetPadding() {
    // check if the user's device has a navigator button bar or not
    return Get.window.viewPadding.bottom > 0 ? 0 : 8;
  }

  static Future<bool> get isBelowIOS14 async {
    return false;
  }

  static void back({dynamic result, bool closeOverlays = false}) {
    if (Get.routing.route?.isFirst == true) {
      SystemNavigator.pop(animated: true);
    } else {
      Get.back(result: result, closeOverlays: closeOverlays);
    }
  }

  static String? mapRouteNameToScreenTrackingName(String routeName) {
    final dicts = {
      RouterName.login: ScreenTrackingName.login,
    };
    final value = dicts[routeName];
    if (value != null) {
      return value.stringValue;
    }
    return null;
  }

  /// return file path base on extension
  /// (external storage for android and document director for ios)
  static Future<String> getDownloadFileName(String fileName) async {
    return 'path';
    // }
  }

  static void handleError(Object error) {
    logDebug("got error ${error.toString()}");
    // isLoading.value = false;
    var message = 'Có lỗi xảy ra, vui lòng thử lại!';
    if (error is AppException) {
      message = error.toString();
    }
    Popup.instance.showSnackBar(message: message, type: SnackbarType.error);
  }

  static void dismissKeyboard() {
    // FocusScope.of(Get.context!).requestFocus(FocusNode());
    FocusManager.instance.primaryFocus?.unfocus();
  }

  static bool isSmallDevice() {
    return Get.width < 375;
  }

  static String dateTimeString(
      {required int millisecondsSinceEpoch, String format = 'dd/MM/yyyy'}) {
    final datetime =
        DateTime.fromMillisecondsSinceEpoch(millisecondsSinceEpoch);
    final now = DateTime.now();
    final datetimeDMY = DateTime(datetime.year, datetime.month, datetime.day);
    final nowDMY = DateTime(now.year, now.month, now.day);
    final diff = datetimeDMY.difference(nowDMY).inDays;
    if (diff == 0) {
      return LocaleKeys.time_today.tr;
    } else if (diff == 1) {
      return LocaleKeys.time_tomorrow.tr;
    } else {
      final dateFormat = DateFormat(format);
      return dateFormat.format(datetime);
    }
  }

  static String addSIfNeeded(int measurement) {
    if (Get.locale?.languageCode == 'en') {
      if (measurement > 1) {
        return 's';
      }
    }
    return '';
  }

  static String _toString(int num) {
    if (num < 10) return "0" + num.toString();
    return num.toString();
  }

  static String toTimerString(int time) {
    int hour = (time / 3600).truncate();
    int minute = ((time - (hour * 60 * 60)) / 60).truncate();
    int seconds = (time - hour * 60 * 60 - minute * 60);
    String str =
        _toString(hour) + ":" + _toString(minute) + ":" + _toString(seconds);
    return str;
  }

  static void showDialog(
      {String title = "",
      String message = "",
      String? cancelText,
      String? confirmText,
      void Function()? onCancel,
      void Function()? onConfirm}) {
    void _onCancel() {
      Get.back();
      onCancel != null ? onCancel() : () => {};
    }

    void _onConfirm() {
      Get.back();
      onConfirm != null ? onConfirm() : () => {};
    }

    Get.dialog(MJDialog(
        title: title,
        content: message,
        cancelTitle: cancelText,
        confirmTitle: confirmText,
        onCancel: _onCancel,
        onConfirm: _onConfirm));
  }

  static void trackScreen(String name) {
    // FirebaseCrashlytics.instance.log('view screen ' + name);
  }
}

class ParserHelper {
  static int? parseInt(dynamic input) {
    if (input != null) {
      if (input is int) {
        return input;
      }
      if (input is double) {
        return input.toInt();
      }
      if (input is String) {
        return int.tryParse(input);
      }
    }
    return null;
  }

  static double? parseDouble(dynamic input) {
    if (input != null) {
      if (input is int) {
        return input.toDouble();
      }
      if (input is double) {
        return input;
      }
      if (input is String) {
        return double.tryParse(input);
      }
    }
    return null;
  }
}
