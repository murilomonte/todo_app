// ignore: unused_import
// ignore: unused_import
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:todo_provider/src/models/user_model.dart';
import 'package:todo_provider/src/services/database_service.dart';

class UserController extends ChangeNotifier {
    final DatabaseService _databaseService = DatabaseService.instance;

    UserModel? _user;
    UserModel? get user => _user; // Getter para uso externo

    // obtém o user
    Future<void> getUser() async {
      _user = await _databaseService.getUser();
      notifyListeners();
    }

    // atualiza o tema
    Future<void> updateUserTheme(String theme) async {
      await _databaseService.updateUserTheme(theme);
      await getUser(); // Atualiza o estado após a mudança
    }

    // Redefine o usuário e apaga suas tasks
    Future<void> resetUserData() async {
      await _databaseService.resetUserData();
      await getUser(); // Atualiza o estado após a mudança
    }

    // atualiza o score
    Future<void> updateUserScore(double score, int status) async {
      await _databaseService.updateUserScore(score, status);
      await getUser(); // Atualiza o estado após a mudança
    }
}