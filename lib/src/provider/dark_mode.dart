import 'package:NewsPapersCo/src/shared_preferenced/dark_prefs.dart';
import 'package:flutter/material.dart';

class ThemeState with ChangeNotifier {

  DarkThemePreference darkThemePreference = DarkThemePreference();
  
 bool _darkTheme = false;

  bool get darkTheme => _darkTheme;

  set darkTheme(bool value) {
    _darkTheme = value;
    darkThemePreference.setDarkTheme(value);
    notifyListeners();
  }
}
