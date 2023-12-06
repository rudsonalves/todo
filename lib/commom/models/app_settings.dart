import 'package:flutter/material.dart';

class AppSettings extends ChangeNotifier {
  AppSettings._();
  static final AppSettings _instance = AppSettings._();
  static AppSettings get instance => _instance;

  ThemeMode _themeMode = ThemeMode.dark;

  ThemeMode get themeMode => _themeMode;

  void toggleTheme() {
    _themeMode =
        (_themeMode == ThemeMode.light) ? ThemeMode.dark : ThemeMode.light;

    notifyListeners();
  }
}
