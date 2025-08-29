import 'dart:developer';

import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/src/database/app_database.dart';

class TodoProvider extends ChangeNotifier {
  List<Task> taskList = [];
  final AppDatabase db = AppDatabase();

  void getAllTask() async {
    List<Task> result = await db.taskDao.getAllTask();
    taskList = result;
    notifyListeners();
  }

  void addTask(TasksCompanion task) async {
    await db.taskDao.addTask(task);
    notifyListeners();
  }

  void addCustomTask() async {
   int result = await db.taskDao.addTask(
      TasksCompanion(status: Value(true), title: Value('Arrumar a cama')),
    );
    notifyListeners();
  }
}
