import 'package:flutter/material.dart';

class AppSettings extends ChangeNotifier {
  AppSettings._();
  static final AppSettings _instance = AppSettings._();
  static AppSettings get instance => _instance;

  ThemeMode _themeMode = ThemeMode.light;

  ThemeMode get themeMode => _themeMode;

  // Change Theme
  void toggleTheme() {
    _themeMode =
        (_themeMode == ThemeMode.light) ? ThemeMode.dark : ThemeMode.light;

    // if (_themeMode == ThemeMode.light) {
    //   _themeMode = ThemeMode.dark;
    // } else {
    //   _themeMode = ThemeMode.light;
    // }

    notifyListeners();
  }
}
