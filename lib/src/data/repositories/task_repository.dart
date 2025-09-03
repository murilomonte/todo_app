import 'package:todo_app/src/data/database/app_database.dart';
import 'package:todo_app/src/data/database/daos/task_dao.dart';

sealed class Result<T> {
  const Result();
}

class Success<T> extends Result<T> {
  final T data;
  Success(this.data);
}

class Failure<T> extends Result<T> {
  final String message;
  Failure(this.message);
}

class TaskRepository {
  final TaskDao dao;

  TaskRepository({required this.dao});

  // -> getTaks
  Future<Result<List<Task>>> getTasks() async {
    try {
      List<Task> taskList = await dao.getAllTask();
      return Success(taskList);
    } catch (err) {
      return Failure('Erro ao buscar tarefas: $err');
    }
  }

  // -> addTask
  Future<Result<int>> addTask(TasksCompanion task) async {
    try {
      int result = await dao.addTask(task);
      return Success(result);
    } catch (err) {
      return Failure('Não foi possível adicionar a task: $err');
    }
  }

  // -> updateTask
  Future<Result<int>> updateTaskStatus(int id, bool isDone) async {
    try {
      int result = await dao.updateTaskStatus(id, isDone);
      return Success(result);
    } catch (err) {
      return Failure('Não foi possível atualizar o status da task: $err');
    }
  }

  // -> delete task
  Future<Result<int>> deleteTask(int id) async {
    try {
      int result = await dao.deleteTask(id);
      return Success(result);
    } catch (err) {
      return Failure('Não foi possível remover a task: $err');
    }
  }
}
