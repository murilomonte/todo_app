// ignore: unused_import
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:todo_app/src/data/database/app_database.dart';

class TodoProvider extends ChangeNotifier {
  List<Task> taskList = [];

  bool isLoading = false;

  List<Task> get pendingTasks =>
      taskList.where((e) => e.status == false).toList();
  List<Task> get completedTasks =>
      taskList.where((e) => e.status == true).toList();

  TodoProvider() {
    _updateTaskList();
  }

  // Getter para pendentes
  // Getter para ja completadas

  final AppDatabase db = AppDatabase();

  void _updateTaskList() async {
    isLoading = true;
    notifyListeners();

    List<Task> result = await db.taskDao.getAllTask();
    taskList = result;

    isLoading = false;
    notifyListeners();
  }

  Future<int> addTask(TasksCompanion task) async {
    try {
      int result = await db.taskDao.addTask(task);
      _updateTaskList();
      return result;
    } catch (err) {
      rethrow;
    }
  }

  // -> toggle task
  Future<int> updateTaskStatus(int id, bool isDone) async {
    try {
      int result = await db.taskDao.updateTaskStatus(id, isDone);
      _updateTaskList();
      return result;
    } catch (err) {
      rethrow;
    }
  }

  // -> delete task
  void deleteTask(int id) async {
    try {
      db.taskDao.deleteTask(id);
      _updateTaskList();
    } catch (err) {
      rethrow;
    }
  }
}
