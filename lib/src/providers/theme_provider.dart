// ignore: unused_import
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_provider/src/theme/dark_mode.dart';
import 'package:todo_provider/src/theme/light_mode.dart';
import 'package:todo_provider/src/providers/user_provider.dart';

class ThemeProvider extends ChangeNotifier {
  final UserProvider _userProvider;
  ThemeData? _themeData;

  ThemeProvider(BuildContext context)
    : _userProvider = Provider.of<UserProvider>(context, listen: false) {
    _initializeTheme(context);
  }

  Future<void> _initializeTheme(BuildContext context) async {
    await _userProvider.getUser();
    _themeData = _userProvider.user!.theme == 'light' ? lightMode : darkMode;
    notifyListeners();
  }

  // Getter
  ThemeData get themeData => _themeData ?? lightMode;
  bool get isDarkMode => _themeData == darkMode;

  // Toggle Theme
  void toggleTheme() {
    _themeData = _themeData == lightMode ? darkMode : lightMode;
    _userProvider.updateUserTheme(isDarkMode ? 'dark' : 'light');
    notifyListeners();
  }
}
