// ignore: unused_import
import 'dart:developer';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_provider/src/models/category_model.dart';
import 'package:todo_provider/src/models/task_model.dart';
import 'package:todo_provider/src/models/user_model.dart';

class DatabaseService {
  // TODO: Buscar uma forma de modularizar o arquivo.

  /*
    O que é preciso:
    - [x] Criação das tabelas das categorias.
    - [ ] Adicionar e remover uma categoria.
    - [ ] Ao completar uma tarefa, deve ser somado ou descontado sua respectiva pontuação na categoria e nos pontos gerais do usuário.
  */

  static Database? _db;

  static final DatabaseService instance = DatabaseService();
  DatabaseService();

  // Esse nome será usado em vários lugares, então é bom deixar algo fixo para evitar erros

  /* Tasks */
  final String _taskTableName = 'tasks';
  final String _taskIdColumnName = 'id';
  final String _taskUserIdColumnName = 'userId';
  final String _taskCategoryIdColumnName = 'categoryId';
  final String _taskTitleColumnName = 'title';
  final String _taskDescriptionColumnName = 'description';
  final String _taskPointsColumnName = 'points';
  final String _taskStatusColumnName = 'status';

  /* Categories */
  final String _categoriesTableName = 'categories';
  final String _categoriesIdColumnName = 'id';
  final String _categoriesNameColumnName = 'name';
  final String _categoriesTotalPointsColumnName = 'totalPoints';

  /* Users */
  final String _userTableName = 'users';
  final String _userIdColumnName = 'id';
  final String _userNameColumnName = 'name';
  final String _userScoreColumnName = 'score';
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
          $_userIdColumnName INTEGER PRIMARY KEY NOT NULL,
          $_userNameColumnName TEXT NOT NULL,
          $_userThemeColumnName TEXT NOT NULL,
          $_userScoreColumnName REAL NOT NULL
        )
        ''');

        await db.execute('''
        CREATE TABLE $_taskTableName (
          $_taskIdColumnName INTEGER PRIMARY KEY NOT NULL,
          $_taskUserIdColumnName INTEGER NOT NULL,
          $_taskCategoryIdColumnName INTEGER NOT NULL,
          $_taskTitleColumnName TEXT NOT NULL,
          $_taskDescriptionColumnName TEXT NOT NULL,
          $_taskPointsColumnName REAL NOT NULL,
          $_taskStatusColumnName INTEGER NOT NULL,
          FOREIGN KEY ($_taskUserIdColumnName) REFERENCES $_userTableName($_taskIdColumnName) ON DELETE CASCADE
          FOREIGN KEY ($_taskCategoryIdColumnName) REFERENCES $_categoriesTableName($_categoriesIdColumnName) ON DELETE CASCADE
        )
        ''');

        await db.execute('''
        CREATE TABLE $_categoriesTableName (
          $_categoriesIdColumnName INTEGER PRIMARY KEY,
          $_categoriesNameColumnName TEXT NOT NULL,
          $_categoriesTotalPointsColumnName REAL NOT NULL
        )
        ''');

        await db.insert(_userTableName, {
          _userIdColumnName: 0,
          _userNameColumnName: 'default',
          _userThemeColumnName: 'light',
          _userScoreColumnName: 0,
        });

        await db.insert(_categoriesTableName, {
          _categoriesIdColumnName: 0,
          _categoriesNameColumnName: 'general',
          _categoriesTotalPointsColumnName: 0,
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
    getTasks();
    return await db.insert(_taskTableName, {
      _taskTitleColumnName: title,
      _taskUserIdColumnName: 0,
      _taskCategoryIdColumnName: 0,
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
            categoryId: e["categoryId"] as int,
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
            categoryId: e["categoryId"] as int,
            title: e["title"] as String,
            description: e["description"] as String,
            points: e["points"] as double,
            status: e["status"] as int,
          );
        }).toList();
    List<Map<String, Object?>> categories = await db.rawQuery('''
        SELECT 
          cat.name, 
          tas.title, 
          tas.id 
        FROM 
          $_categoriesTableName AS cat, 
          $_taskTableName AS tas 
        WHERE 
          cat.id = 0 AND 
          cat.id = tas.categoryId
     ''');
    //log('$categories');
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
  Future<void> deleteTask(int id) async {
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
  Future<void> updateUserScore(double score, int status) async {
    final db = await database;
    UserModel userData = await getUser();
    double newScore =
        status == 0 ? userData.score + score : userData.score - score;
    await db.update(
      _userTableName,
      {_userScoreColumnName: newScore},
      where: 'id = ?',
      whereArgs: [0],
    );
    // log('[Score] User 0 -> score $newScore');
  }

  // Redefine o usuário e apaga suas tasks

  Future<void> resetUserData() async {
    final db = await database;
    await db.delete(_taskTableName, where: 'userId = ?', whereArgs: [0]);
    await db.delete(_userTableName, where: 'id = ?', whereArgs: [0]);
    await db.insert(_userTableName, {
      _userIdColumnName: 0,
      _userNameColumnName: 'default',
      _userThemeColumnName: 'light',
      _userScoreColumnName: 0,
    });
  }

  /*
    Category methods
  */

  // TODO: Testar
  // Adiciona uma categoria
  Future<int> addCategory({String? name}) async {
    final db = await database;
    return await db.insert(_categoriesTableName, {
      _categoriesNameColumnName: name,
      _categoriesTotalPointsColumnName: 0,
    });
  }

  // TODO: Testar
  // Remove uma categoria
  Future<void> deleteCategory(int id) async {
    final db = await database;
    await db.delete(_categoriesTableName, where: 'id = ?', whereArgs: [id]);
  }

  // TODO: Testar
  // Retorna a lista de categorias
  Future<List<CategoryModel>> getCategories({
    bool search = false,
    int id = 0,
  }) async {
    final db = await database;
    late List<Map<String, Object?>> data;
    // Consulta no banco de dados
    if (search) {
      data = await db.query(
        _categoriesTableName,
        where: 'id = ?',
        whereArgs: [id],
      );
      // Teste
      List<Map<String, Object?>> categories = await db.rawQuery('''
        SELECT 
          cat.id, 
          cat.name, 
          cat.totalPoints 
        FROM 
          $_categoriesTableName AS cat
        WHERE
          cat.id = $id
      ''');
      //log('$categories');
    } else {
      data = await db.query(_categoriesTableName);

      // Teste
      List<Map<String, Object?>> categories = await db.rawQuery('''
        SELECT 
          cat.id, 
          cat.name, 
          cat.totalPoints 
        FROM 
          $_categoriesTableName AS cat
        WHERE
          cat.id = $id
     ''');
      //log('$categories');
    }
    // pega o resultado e transforma em uma lista
    List<CategoryModel> category =
        data.map((e) {
          return CategoryModel(
            id: e["id"] as int,
            name: e["name"] as String,
            totalPoints: e["totalPoints"] as double,
          );
        }).toList();

    return category;
  }

  // TODO: Testar
  // Atualiza o score da categoria

  /// - id -> specified category id
  ///
  /// - score -> new category score
  ///
  /// - taskStatus -> current task status
  ///
  ///   - Used to determine if it will sum or subtract the score
  Future<void> updateCategoryScore({
    required int id,
    required double score,
    required int taskStatus,
  }) async {
    final db = await database;
    List<CategoryModel> category = await getCategories(search: true, id: id);
    log('objeto no index 0 -> ${category}');
    double newScore =
        taskStatus == 0
            ? category[0].totalPoints - score
            : category[0].totalPoints + score;
    newScore = newScore < 0 ? 0 : newScore;
    log('$newScore');
    await db.update(
      _categoriesTableName,
      {_categoriesTotalPointsColumnName: newScore},
      where: 'id = ?',
      whereArgs: [id],
    );
    // log('[Score] User 0 -> score $newScore');
  }
}
