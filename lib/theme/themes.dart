import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'colors.dart';

class AppThemes {
  final String _sThemeModeKey = 'S_THEME_MODE_KEY';
  final String _sThemeModeLight = '_sThemeModeLight';
  final String _sThemeModeDark = '_sThemeModeDark';

  // static const String _sfProDisplayFontFamily = 'SFProDisplay';
  // static const String _sfProTextFontFamily = 'SFProText';
  // static const String _robotoFontFamily = 'Roboto';
  static const String interFontFamily = 'Inter';

  static String get _displayAndHeadlingFontFamily {
    return interFontFamily;
  }

  static String get _bodyFontFamily {
    return interFontFamily;
  }

  static FontWeight get _fontWeightMediumOrSemibold {
    return Platform.isAndroid ? FontWeight.w500 : FontWeight.w600;
  }

  static ThemeData instance = _lightTheme;

  // LIGHT THEME TEXT
  static final TextTheme _lightTextTheme = TextTheme(
    headline1: TextStyle(
        fontSize: 40.0,
        fontFamily: _displayAndHeadlingFontFamily,
        fontWeight: FontWeight.bold,
        height: 60.0 / 40.0,
        color: GPColor.contentPrimary),
    headline2: TextStyle(
        fontSize: 32.0,
        fontFamily: _displayAndHeadlingFontFamily,
        fontWeight: FontWeight.bold,
        height: 50.0 / 32.0,
        color: GPColor.contentPrimary),
    headline3: TextStyle(
        fontSize: 24,
        fontFamily: _displayAndHeadlingFontFamily,
        fontWeight: FontWeight.w500,
        height: 40.0 / 24.0,
        color: GPColor.contentPrimary),
    headline4: TextStyle(
        fontSize: 28.0,
        fontFamily: _displayAndHeadlingFontFamily,
        fontWeight: _fontWeightMediumOrSemibold,
        height: 36.0 / 28.0,
        color: GPColor.contentPrimary),
    headline5: TextStyle(
        fontSize: 24.0,
        fontFamily: _displayAndHeadlingFontFamily,
        fontWeight: _fontWeightMediumOrSemibold,
        height: 32.0 / 24.0,
        color: GPColor.contentPrimary),
    headline6: TextStyle(
        fontSize: 20.0,
        fontFamily: _displayAndHeadlingFontFamily,
        fontWeight: _fontWeightMediumOrSemibold,
        height: 28.0 / 20.0,
        color: GPColor.contentPrimary),
    subtitle1: TextStyle(
        fontSize: 20.0,
        fontFamily: _displayAndHeadlingFontFamily,
        fontWeight: FontWeight.normal,
        height: 32.0 / 20.0,
        color: GPColor.contentPrimary),
    subtitle2: TextStyle(
        fontSize: 16.0,
        fontFamily: _displayAndHeadlingFontFamily,
        fontWeight: _fontWeightMediumOrSemibold,
        height: 24.0 / 16.0,
        color: GPColor.contentPrimary),
    caption: TextStyle(
        fontSize: 14.0,
        fontFamily: _bodyFontFamily,
        fontWeight: _fontWeightMediumOrSemibold,
        height: 20.0 / 14.0,
        color: GPColor.contentPrimary),
    bodyText1: TextStyle(
      fontSize: 16.0,
      fontFamily: _bodyFontFamily,
      fontWeight: FontWeight.normal,
      height: 26.0 / 16.0,
      color: GPColor.contentPrimary,
    ),
    bodyText2: TextStyle(
      fontSize: 14.0,
      fontFamily: _bodyFontFamily,
      height: 20.0 / 14.0,
      color: GPColor.contentPrimary,
    ),
    overline: TextStyle(
      fontSize: 12.0,
      fontFamily: _bodyFontFamily,
      height: 16.0 / 12.0,
      color: GPColor.contentPrimary,
    ),
    button: TextStyle(
      fontSize: 18.0,
      fontFamily: _displayAndHeadlingFontFamily,
      fontWeight: FontWeight.bold,
      height: 32.0 / 18.0,
      color: GPColor.contentPrimary,
    ),
  );

  // DARK THEME TEXT
  static final TextTheme _darkTextTheme = TextTheme(
    headline1: TextStyle(
        fontSize: 40.0,
        fontFamily: _displayAndHeadlingFontFamily,
        fontWeight: FontWeight.bold,
        height: 60.0 / 40.0,
        leadingDistribution: TextLeadingDistribution.even,
        color: GPColor.darkContentPrimary),
    headline2: TextStyle(
        fontSize: 32.0,
        fontFamily: _displayAndHeadlingFontFamily,
        fontWeight: FontWeight.bold,
        height: 50.0 / 32.0,
        leadingDistribution: TextLeadingDistribution.even,
        color: GPColor.darkContentPrimary),
    headline3: TextStyle(
        fontSize: 24.0,
        fontFamily: _displayAndHeadlingFontFamily,
        fontWeight: FontWeight.bold,
        height: 40.0 / 24.0,
        leadingDistribution: TextLeadingDistribution.even,
        color: GPColor.darkContentPrimary),
    headline4: TextStyle(
        fontSize: 28.0,
        fontFamily: _displayAndHeadlingFontFamily,
        fontWeight: _fontWeightMediumOrSemibold,
        height: 36.0 / 28.0,
        color: GPColor.darkContentPrimary),
    headline5: TextStyle(
        fontSize: 24.0,
        fontFamily: _displayAndHeadlingFontFamily,
        fontWeight: _fontWeightMediumOrSemibold,
        height: 32.0 / 24.0,
        color: GPColor.darkContentPrimary),
    headline6: TextStyle(
        fontSize: 20.0,
        fontFamily: _displayAndHeadlingFontFamily,
        fontWeight: _fontWeightMediumOrSemibold,
        height: 28.0 / 20.0,
        color: GPColor.darkContentPrimary),
    subtitle1: TextStyle(
        fontSize: 20.0,
        fontFamily: _displayAndHeadlingFontFamily,
        fontWeight: FontWeight.normal,
        height: 32.0 / 20.0,
        leadingDistribution: TextLeadingDistribution.even,
        color: GPColor.darkContentPrimary),
    subtitle2: TextStyle(
        fontSize: 16.0,
        fontFamily: _displayAndHeadlingFontFamily,
        fontWeight: _fontWeightMediumOrSemibold,
        height: 24.0 / 16.0,
        leadingDistribution: TextLeadingDistribution.even,
        color: GPColor.darkContentPrimary),
    caption: TextStyle(
        fontSize: 14.0,
        fontFamily: _displayAndHeadlingFontFamily,
        fontWeight: _fontWeightMediumOrSemibold,
        height: 20.0 / 14.0,
        leadingDistribution: TextLeadingDistribution.even,
        color: GPColor.darkContentPrimary),
    bodyText1: TextStyle(
      fontSize: 16.0,
      fontFamily: _bodyFontFamily,
      fontWeight: FontWeight.normal,
      height: 26.0 / 16.0,
      leadingDistribution: TextLeadingDistribution.even,
      color: GPColor.darkContentPrimary,
    ),
    bodyText2: TextStyle(
      fontSize: 14.0,
      fontFamily: _bodyFontFamily,
      height: 20.0 / 14.0,
      leadingDistribution: TextLeadingDistribution.even,
      color: GPColor.darkContentPrimary,
    ),
    overline: TextStyle(
      fontSize: 12.0,
      fontFamily: _bodyFontFamily,
      height: 16.0 / 12.0,
      color: GPColor.darkContentPrimary,
    ),
    button: TextStyle(
      fontSize: 18.0,
      fontFamily: _displayAndHeadlingFontFamily,
      fontWeight: FontWeight.bold,
      leadingDistribution: TextLeadingDistribution.even,
      height: 32.0 / 18.0,
      color: GPColor.darkContentPrimary,
    ),
  );

  // LIGHT THEME
  static final ThemeData _lightTheme = ThemeData(
    primaryColorBrightness: Brightness.light,
    fontFamily: _bodyFontFamily,
    primaryColor: GPColor.workPrimary,
    scaffoldBackgroundColor: GPColor.bgPrimary,
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: GPColor.workPrimary,
    ),
    appBarTheme: const AppBarTheme(
      color: GPColor.bgPrimary,
      iconTheme: IconThemeData(color: GPColor.contentPrimary),
    ),
    colorScheme: const ColorScheme.light(
      primary: GPColor.workPrimary,
      primaryVariant: GPColor.bgSecondary,
    ),
    snackBarTheme:
        const SnackBarThemeData(backgroundColor: GPColor.contentPrimary),
    iconTheme: const IconThemeData(
      color: GPColor.contentInversePrimary,
    ),
    popupMenuTheme: const PopupMenuThemeData(color: GPColor.bgPrimary),
    textTheme: _lightTextTheme,
  );

  // DARK THEME
  static final ThemeData _darkTheme = ThemeData(
    brightness: Brightness.dark,
    fontFamily: _bodyFontFamily,
    primaryColor: GPColor.workPrimary,
    scaffoldBackgroundColor: GPColor.darkBgPrimary,
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: GPColor.workPrimary,
    ),
    appBarTheme: const AppBarTheme(
      color: GPColor.darkBgPrimary,
      iconTheme: IconThemeData(color: GPColor.contentSecondary),
    ),
    colorScheme: const ColorScheme.dark(
      primary: GPColor.bgInversePrimary,
      primaryVariant: GPColor.bgSecondary,
    ),
    snackBarTheme:
        const SnackBarThemeData(backgroundColor: GPColor.bgSecondary),
    iconTheme: const IconThemeData(
      color: GPColor.bgInversePrimary,
    ),
    popupMenuTheme: const PopupMenuThemeData(color: GPColor.bgInversePrimary),
    textTheme: _darkTextTheme,
  );

  /// LIGHT THEME
  static ThemeData theme() {
    return _darkTheme;
  }

  /// DARK THEME
  static ThemeData darktheme() {
    return _darkTheme;
  }

  ThemeMode init() {
    final box = GetStorage();
    String? tm = box.read(_sThemeModeKey);
    if (tm == null) {
      box.write(_sThemeModeKey, _sThemeModeLight);
      instance = _lightTheme;
      return ThemeMode.light;
    } else if (tm == _sThemeModeLight) {
      instance = _lightTheme;
      return ThemeMode.light;
    } else {
      instance = _darkTheme;
      return ThemeMode.dark;
    }
  }

  void changeThemeMode(ThemeMode themeMode) {
    final box = GetStorage();
    if (themeMode == ThemeMode.dark) {
      instance = _darkTheme;
      box.write(_sThemeModeKey, _sThemeModeDark);
    } else {
      instance = _lightTheme;
      box.write(_sThemeModeKey, _sThemeModeLight);
    }
    Get.changeThemeMode(themeMode);
    Get.rootController.themeMode.reactive;
  }

  ThemeData general() {
    return instance;
  }
}
