import 'dart:developer';

import 'package:drift/drift.dart';
import 'package:todo_app/src/database/app_database.dart';
import 'package:todo_app/src/database/tables/tasks.dart';

part 'task_dao.g.dart';

@DriftAccessor(tables: [Tasks])
class TaskDao extends DatabaseAccessor<AppDatabase> with _$TaskDaoMixin {
  TaskDao(super.db);
  // TaskDao(AppDatabase db) : super(db);

  Future<List<Task>> getAllTask() async {
   List<Task> result = await select(tasks).get();
   log('dao');
   return result;
   
  }

  Future<int> addTask(TasksCompanion task) => into(tasks).insert(task);
}
