// ignore: unused_import
import 'dart:developer';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_provider/models/task_model.dart';
import 'package:todo_provider/models/user_model.dart';

class DatabaseService {
  static Database? _db;

  static final DatabaseService instance = DatabaseService();
  DatabaseService();

  // Esse nome será usado em vários lugares, então é bom deixar algo fixo para evitar erros
  final String _taskTableName = 'tasks';
  final String _taskIdColumnName = 'id';
  final String _taskUserIdColumnName = 'userId';
  final String _taskTitleColumnName = 'title';
  final String _taskDescriptionColumnName = 'description';
  final String _taskPointsColumnName = 'points';
  final String _taskStatusColumnName = 'status';

  final String _userTableName = 'users';
  final String _userIdColumnName = 'id';
  final String _userNameColumnName = 'name';
  final String _userScoreCoulumnName = 'score';
  final String _userThemeColumnName = 'theme';

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await getDatabase();
    return _db!;
  }

  Future<Database> getDatabase() async {
    // Identifica onde o banco de dados será criado
    final dabataseDirPath = await getDatabasesPath();
    // Define um nome para o banco de dados a partir da sua localização
    final databasePath = join(dabataseDirPath, "master_db.db");
    // Abrindo o banco de dados
    final database = await openDatabase(
      databasePath,
      version: 2,
      onCreate: (db, version) async {
        await db.execute('PRAGMA foreign_keys = ON;');
        await db.execute('''
        CREATE TABLE $_userTableName (
          $_userIdColumnName INTEGER PRIMARY KEY,
          $_userNameColumnName TEXT NOT NULL,
          $_userThemeColumnName TEXT NOT NULL,
          $_userScoreCoulumnName REAL NOT NULL
        )
        ''');
        await db.execute('''
        CREATE TABLE $_taskTableName (
          $_taskIdColumnName INTEGER PRIMARY KEY,
          $_taskUserIdColumnName INTEGER,
          $_taskTitleColumnName TEXT NOT NULL,
          $_taskDescriptionColumnName TEXT NOT NULL,
          $_taskPointsColumnName REAL NOT NULL,
          $_taskStatusColumnName INTEGER NOT NULL,
          FOREIGN KEY ($_taskUserIdColumnName) REFERENCES $_userTableName($_taskIdColumnName) ON DELETE CASCADE
        )
        ''');
        await db.insert(_userTableName, {
          _userIdColumnName: 0,
          _userNameColumnName: 'default',
          _userThemeColumnName: 'light',
          _userScoreCoulumnName: 0,
        });
      },
    );
    return database;
  }

  /*
    Tasks methods
  */

  // Adiciona uma task
  Future<int> addTask({
    String? title,
    String? description,
    double? points = 0,
  }) async {
    final db = await database;
    return await db.insert(_taskTableName, {
      _taskTitleColumnName: title,
      _taskUserIdColumnName: 0,
      _taskDescriptionColumnName: description,
      _taskPointsColumnName: points,
      _taskStatusColumnName: 0,
    });
  }

  // Mesclar com o getTasks?
  Future<TaskModel> getTaskById(int id) async {
    final db = await database;
    List<Map<String, Object?>> data = await db.query(
      _taskTableName,
      where: 'id = ?',
      whereArgs: [id],
    );
    List<TaskModel> tasks =
        data.map((e) {
          return TaskModel(
            id: e["id"] as int,
            userId: e["userId"] as int,
            title: e["title"] as String,
            description: e["description"] as String,
            points: e["points"] as double,
            status: e["status"] as int,
          );
        }).toList();
    return tasks[0];
  }

  // Retorna a lista de tasks
  Future<List<TaskModel>> getTasks() async {
    final db = await database;
    // Consulta no banco de dados
    List<Map<String, Object?>> data = await db.query(_taskTableName);
    // pega o resultado e transforma em uma lista
    List<TaskModel> tasks =
        data.map((e) {
          return TaskModel(
            id: e["id"] as int,
            userId: e["userId"] as int,
            title: e["title"] as String,
            description: e["description"] as String,
            points: e["points"] as double,
            status: e["status"] as int,
          );
        }).toList();
    return tasks;
  }

  // Atualiza o status de uma task
  Future<void> updateTaskStatus(int id, int status) async {
    final db = await database;
    await db.update(
      _taskTableName,
      {_taskStatusColumnName: status},
      where: 'id = ?',
      whereArgs: [id],
    );
    // log('$id -> status $status');
  }

  // Deleta uma task
  void deleteTask(int id) async {
    final db = await database;
    await db.delete(_taskTableName, where: 'id = ?', whereArgs: [id]);
  }

  /*
    User methods
  */

  // Retorna o user
  Future<UserModel> getUser() async {
    final db = await database;
    // Consulta no banco de dados
    List<Map<String, Object?>> data = await db.query(_userTableName);
    // pega o resultado e transforma em uma lista
    List<UserModel> user =
        data.map((e) {
          return UserModel(
            id: e["id"] as int,
            name: e["name"] as String,
            theme: e["theme"] as String,
            score: e["score"] as double,
          );
        }).toList();
    return user[0];
  }

  // Atualiza o tema
  Future<void> updateUserTheme(String theme) async {
    final db = await database;
    await db.update(
      _userTableName,
      {_userThemeColumnName: theme},
      where: 'id = ?',
      whereArgs: [0],
    );
    // log('[Theme] User 0 -> theme $theme');
  }

  // Atualiza o score
  Future<void> updateUserScore(double score) async {
    final db = await database;
    UserModel userData = await getUser();
    double newScore = userData.score + score;
    await db.update(
      _userTableName,
      {_userScoreCoulumnName: newScore},
      where: 'id = ?',
      whereArgs: [0],
    );
    // log('[Score] User 0 -> score $newScore');
  }
}
