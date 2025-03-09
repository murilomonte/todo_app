// ignore: unused_import
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:todo_provider/src/models/task_model.dart';
import 'package:todo_provider/src/services/database_service.dart';

class TodoProvider extends ChangeNotifier {
  TodoProvider(){
    Future.microtask(() => updateTaskList());
  }

  final DatabaseService _databaseService = DatabaseService.instance;

  // taks
  List<TaskModel> _tasks = [];

  List<TaskModel> get pendingTasks {
    log('[run] -> pendingTasks');
    return _tasks.where((item) => item.status == 0).toList();
  }

  List<TaskModel> get completedTasks {
    log('[run] -> completedTasks');
    return _tasks.where((item) => item.status == 1).toList();
  }

  // Obtém as tasks
  Future<void> updateTaskList() async {
    _tasks = await _databaseService.getTasks();
    log('[run] -> updateTaskList');
    notifyListeners();
  }

  // Adiciona uma task
  void addTask({String? title, String? description, double? points = 0}) async {
    await _databaseService.addTask(
      title: title,
      description: description,
      points: points,
    );
    log('[run] -> addTaskList');
    await updateTaskList();
  }

  // Deleta uma task
  Future<void> deleteTask(int id) async {
    await _databaseService.deleteTask(id);
    log('[run] -> deleteTask');
    await updateTaskList();
  }

  // Trasita as taks entre listas
  Future<void> toggleTask(int id, int status) async {
    _databaseService.updateTaskStatus(id, status);
    log('[run] -> toggleTask');
    await updateTaskList();
  }
}
