// ignore: unused_import
import 'dart:developer';

import 'package:drift/drift.dart';
import 'package:todo_app/src/database/app_database.dart';
import 'package:todo_app/src/database/tables/tasks.dart';

part 'task_dao.g.dart';

@DriftAccessor(tables: [Tasks])
class TaskDao extends DatabaseAccessor<AppDatabase> with _$TaskDaoMixin {
  TaskDao(super.db);
  // TaskDao(AppDatabase db) : super(db);

  Future<List<Task>> getAllTask() => select(tasks).get();

  Future<int> addTask(TasksCompanion task) => into(tasks).insert(task);

  // -> toggle task
  Future<int> updateTaskStatus(int id, bool isDone) =>
      (update(tasks)..where((t) => t.id.equals(id))).write(
        TasksCompanion(status: Value(isDone)),
      );

  // -> delete task
  void deleteTask(int id) => delete(tasks).where((tbl) => tbl.id.isValue(id));
}
