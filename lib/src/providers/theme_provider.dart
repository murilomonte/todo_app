// ignore: unused_import
// ignore: unused_import
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_provider/src/theme/dark_mode.dart';
import 'package:todo_provider/src/theme/light_mode.dart';
import 'package:todo_provider/src/providers/user_provider.dart';

class ThemeProvider extends ChangeNotifier {
  final UserProvider userProvider = UserProvider();
  ThemeData _themeData = lightMode;

  ThemeProvider(BuildContext context) {
    // Future.microtask é executado antes de quaisquer Future comum
    Future.microtask(() => getUserPrefs(context));
  }

  void getUserPrefs(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context ,listen: false);
    await userProvider.getUser();
    _themeData = userProvider.user!.theme == 'light' ? lightMode : darkMode;
    notifyListeners();
  }

  // Getter
  get themeData => _themeData;
  bool get isDarkMode => _themeData == darkMode;

  // Setter
  set themeMode(ThemeData theme) {
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
