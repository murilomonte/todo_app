// ignore: unused_import
// ignore: unused_import
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:todo_provider/src/theme/dark_mode.dart';
import 'package:todo_provider/src/theme/light_mode.dart';
import 'package:todo_provider/src/providers/user_provider.dart';

class ThemeProvider extends ChangeNotifier {
  final UserProvider userProvider = UserProvider();
  ThemeData _themeData = lightMode;

  void getUserPrefs() async {
    final userPrefs = await UserProvider().getUser();
    _themeData = userPrefs.theme == 'light' ? lightMode : darkMode;
    notifyListeners();
  }

  ThemeProvider() {
    getUserPrefs();
  }

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
      userProvider.updateUserTheme('dark');
    } else {
      _themeData = lightMode;
      userProvider.updateUserTheme('light');
    }
    notifyListeners();
  }
  
}