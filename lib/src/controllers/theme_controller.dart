// ignore: unused_import
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_provider/src/theme/dark_mode.dart';
import 'package:todo_provider/src/theme/light_mode.dart';
import 'package:todo_provider/src/controllers/user_controller.dart';

class ThemeController extends ChangeNotifier {
  final UserController _userController;
  ThemeData? _themeData;

  ThemeController(BuildContext context)
    : _userController = Provider.of<UserController>(context, listen: false) {
    _initializeTheme(context);
  }

  Future<void> _initializeTheme(BuildContext context) async {
    await _userController.getUser();
    _themeData = _userController.user!.theme == 'light' ? lightMode : darkMode;
    notifyListeners();
  }

  // Getter
  ThemeData get themeData => _themeData ?? lightMode;
  bool get isDarkMode => _themeData == darkMode;

  // Toggle Theme
  void toggleTheme() {
    _themeData = _themeData == lightMode ? darkMode : lightMode;
    _userController.updateUserTheme(isDarkMode ? 'dark' : 'light');
    notifyListeners();
  }
}
