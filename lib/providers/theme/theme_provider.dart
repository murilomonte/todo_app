import 'package:flutter/material.dart';
import 'package:todo_provider/providers/theme/dark_mode.dart';
import 'package:todo_provider/providers/theme/light_mode.dart';

class ThemeProvider extends ChangeNotifier {
  // iniciamente no lightmode
  // ThemeData _themeData = lightMode;
  ThemeData _themeData = darkMode;

  // Getter
  get themeData => _themeData;
  bool get isDarkMode => _themeData == darkMode;

  // Setter
  set themMode(ThemeData theme) {
    _themeData = theme;
    notifyListeners();
  }

  // Toggle Theme
  void toggleTheme() {
    if (_themeData == lightMode) {
      _themeData = darkMode;
    } else {
      _themeData = lightMode;
    }
    notifyListeners();
  }
  
}