import 'package:flutter/material.dart';
import 'package:social_media_app/presentation/themes/dark_theme.dart';
import 'package:social_media_app/presentation/themes/light_theme.dart';

class ThemeProvider with ChangeNotifier {
  late ThemeData _themeData;

  ThemeProvider({required Brightness brightness}) {
    _themeData = brightness == Brightness.dark ? darkTheme : lightTheme;
  }

  ThemeData get themeData => _themeData;

  set themeData(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
  }

  void toggleTheme() {
    _themeData = _themeData == lightTheme ? darkTheme : lightTheme;
    notifyListeners();
  }
}
