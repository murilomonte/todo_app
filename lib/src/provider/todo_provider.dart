// ignore: unused_import
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:todo_app/src/data/database/app_database.dart';
import 'package:todo_app/src/data/repositories/task_repository.dart';

class TodoProvider extends ChangeNotifier {
  List<Task> _taskList = [];

  bool isLoading = false;
  String? errorMessage;

  List<Task> get pendingTasks =>
      _taskList.where((e) => e.status == false).toList();
  List<Task> get completedTasks =>
      _taskList.where((e) => e.status == true).toList();

  TodoProvider({required this.repository}) {
    _updateTaskList();
  }

  // Getter para pendentes
  // Getter para ja completadas
  TaskRepository repository;

  void _updateTaskList() async {
    isLoading = true;
    notifyListeners();

    final result = await repository.getTasks();

    switch (result) {
      case Success(data: List<Task> taskList):
        _taskList = taskList;
        errorMessage = null;
        break;

      case Failure(message: String message):
        errorMessage = message;
        break;
    }

    isLoading = false;
    notifyListeners();
  }

  Future<Result<void>> addTask(TasksCompanion task) async {
    final result = await repository.addTask(task);

    switch (result) {
      case Success():
        _updateTaskList();
        return result;

      case Failure(message: String message):
        errorMessage = message;
        notifyListeners();
        return Failure(message);
    }
  }

  // -> toggle task
  void updateTaskStatus(int id, bool isDone) async {
    final result = await repository.updateTaskStatus(id, isDone);

    switch (result) {
      case Success():
        _updateTaskList();
        break;

      case Failure(message: String message):
        errorMessage = message;
        notifyListeners();
        break;
    }
  }

  // -> delete task
  void deleteTask(int id) async {
    final result = await repository.deleteTask(id);
    switch (result) {
      case Success():
        _updateTaskList();
        break;

      case Failure(message: String message):
        errorMessage = message;
        notifyListeners();
        break;
    }
  }
}
