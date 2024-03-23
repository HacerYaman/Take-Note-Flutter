import 'package:flutter/material.dart';
import 'package:take_note/theme/theme.dart';

class ThemeProvider with ChangeNotifier {
  ThemeData _themeData = lightMode;

  ThemeData get themeData =>
      _themeData; //getter method to access the theme from other parts of the code

  bool get isDarkMode =>
      _themeData ==
      darkMode; //getter method to see if we are in dark mode or not

  set themeData(ThemeData themeData) {
    // setter method to set the nwe theme
    _themeData = themeData;
    notifyListeners();
  }

  void toggleTheme() {
    if (_themeData == lightMode) {
      themeData = darkMode;
    } else {
      themeData = lightMode;
    }
  }
}
