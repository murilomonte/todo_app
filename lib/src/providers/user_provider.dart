// ignore: unused_import
// ignore: unused_import
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:todo_provider/src/models/user_model.dart';
import 'package:todo_provider/src/services/database_service.dart';

class UserProvider extends ChangeNotifier {
    final DatabaseService _databaseService = DatabaseService.instance;

    // obtém o user
    Future<UserModel> getUser() async {
      UserModel user = await _databaseService.getUser();
      return user;
    }

    // atualiza o tema
    void updateUserTheme(String theme) async {
      await _databaseService.updateUserTheme(theme);
    }

    // atualiza o score
    void updateUserScore(double score) async {
      await _databaseService.updateUserScore(score);
    }
}