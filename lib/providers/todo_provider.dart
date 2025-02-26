import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class TodoProvider extends ChangeNotifier {
  // taks
  final List<TaskItem> _pendingTasks = [];
  final List<TaskItem> _completedTasks = [];

  List<TaskItem> get pendingTasks => _pendingTasks;
  List<TaskItem> get completedTasks => _completedTasks;

  // Adiciona uma task
  void addTask({
    String? title,
    String? description,
    double? points = 0,
  }) {
    // Overengineering? Maybe
    Uuid id = Uuid();
    _pendingTasks.add(
      TaskItem(
        id: id.v1(),
        name: title!,
        description: description!,
        points: points!,
        completed: false,
      ),
    );
    notifyListeners();
  }

  // Deleta uma task
  void deleteTask(int index, String id) {
    if (index < _pendingTasks.length && _pendingTasks[index].id == id) {
      _pendingTasks.removeAt(index);
    } else if (index < _completedTasks.length &&
        _completedTasks[index].id == id) {
      _completedTasks.removeAt(index);
    }
    notifyListeners();
  }

  // Trasita as taks entre listas
  void toggleTask(int index, String id) {
    // verifica se a task foi completada ou não. Com base nisso, transita para outra lista de tarefas
    if (index < _pendingTasks.length && _pendingTasks[index].id == id) {
      TaskItem task = _pendingTasks.removeAt(index);
      task.completed = true;
      _completedTasks.add(task);
    } else if (index < _completedTasks.length &&
        _completedTasks[index].id == id) {
      TaskItem task = _completedTasks.removeAt(index);
      task.completed = false;
      pendingTasks.add(task);
    }
    notifyListeners();
  }
}

class TaskItem {
  String id;
  String name;
  String description;
  double points;
  bool completed;
  TaskItem({
    required this.id,
    required this.name,
    required this.description,
    required this.points,
    required this.completed,
  });
}
