// ignore: unused_import
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:todo_provider/src/models/task_model.dart';
import 'package:todo_provider/src/services/database_service.dart';

class TodoController extends ChangeNotifier {
  final DatabaseService _databaseService = DatabaseService.instance;

  // taks
  List<TaskModel> _tasks = [];
  List<TaskModel> _pendingTasks = [];
  List<TaskModel> _completedTasks = [];
  bool _isInitialized = false;

  List<TaskModel> get pendingTasks => _pendingTasks;
  List<TaskModel> get completedTasks => _completedTasks;
  

  TodoController() {
    _initialize();
  }

  Future<void> _initialize() async {
    // Se já estiver inicializado, ignora
    if (_isInitialized) return;
    await updateTaskList(silent: true);
    _isInitialized = true;
  }

  // Obtém as tasks
  Future<void> updateTaskList({silent = false}) async {
    _tasks = await _databaseService.getTasks();
    _updateFilteredTaskList();
    log('[run] -> updateTaskList');
    
    // Deixa de atualizar a interface quando requisitado
    if (!silent) notifyListeners();
  }

  // Torna possível atualizar as listas filtradas junto a principal
  void _updateFilteredTaskList() {
    log('[run] -> _updateFilteredTaskList');
    _pendingTasks = _tasks.where((item) => item.status == 0).toList();
    _completedTasks = _tasks.where((item) => item.status == 1).toList();
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

  // Muda o status da task
  Future<void> toggleTask(int id, int status) async {
    // Verifica se o indice informado existe
    // indexWhere retorna o primeiro item que atender a especificação
    final int index = _tasks.indexWhere((task) => task.id == id);

    if (index != -1) {
      _tasks[index] = _tasks[index].copyWith(status: status);
    }

    _databaseService.updateTaskStatus(id, status);
    log('[run] -> toggleTask');
    await updateTaskList();
  }
}
