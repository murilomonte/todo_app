// ignore: unused_import
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:todo_app/src/database/app_database.dart';

class TodoProvider extends ChangeNotifier {
  List<Task> taskList = [];

  // Getter para pendentes
  // Getter para ja completadas

  final AppDatabase db = AppDatabase();

  void updateTaskList() async {
    List<Task> result = await db.taskDao.getAllTask();
    taskList = result;
    log('updateTaskList');
    notifyListeners();
  }

  Future<int> addTask(TasksCompanion task) async {
    try {
      int result = await db.taskDao.addTask(task);
      updateTaskList();
      return result;
    } catch (err) {
      rethrow;
    }
  }

  // -> toggle task

  // -> delete task
}
