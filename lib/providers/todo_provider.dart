import 'package:flutter/material.dart';

class TodoProvider extends ChangeNotifier {
  // taks
  // final List<String> _tasks = [];
  final List<TaskItem> _tasks = [];

  List<TaskItem> get tasks => _tasks;

  // add task
  void addTask(String value) {
    _tasks.add(TaskItem(name: value, completed: false));
    notifyListeners();
  }

  // mark task as completed
  void markTask(int index) {
    _tasks[index].completed = !_tasks[index].completed;
    notifyListeners();
  }
}

class TaskItem {
  String name;
  bool completed;
  TaskItem({required this.name, required this.completed});
}
