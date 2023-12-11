import 'dart:developer';
import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import 'helper.dart';

class SqfliteHelper implements Helper {
  SqfliteHelper._();
  static SqfliteHelper _instange() => SqfliteHelper._();
  static SqfliteHelper get instance => _instange();

  static const _dbName = 'task_database.db';
  static const _dbVersion = 1;

  static const taskTable = 'taskTable';
  static const taskId = 'id';
  static const taskDescription = 'description';
  static const taskIsDone = 'isDone';

  late Database _db;

  @override
  Future<void> init() async {
    try {
      await _openDatabase();
    } catch (err) {
      log('Database opening error: $err');
    }
  }

  @override
  Future<void> restartTables() async {
    if (!_db.isOpen) await _openDatabase();

    try {
      // Drop tables
      await _dropTables();
      await _onCreate(_db, _dbVersion);
    } catch (err) {
      log('Restart tables error: $err');
    }
  }

  Future<void> _openDatabase() async {
    try {
      final Directory directory = await getApplicationDocumentsDirectory();
      final String path = join(directory.path, _dbName);

      _db = await openDatabase(
        path,
        version: _dbVersion,
        onCreate: _onCreate,
        // onConfigure: _onConfigure,
      );
    } catch (err) {
      log('_openDatabase error: $err');
    }
  }

  Future<void> _onCreate(Database db, int version) async {
    try {
      Batch bath = db.batch();
      // Tables
      _createTaskTable(bath);
      // Commit tables
      await bath.commit();
    } catch (err) {
      log('Database create error: $err');
    }
  }

  void _createTaskTable(Batch batch) {
    batch.execute(
      'CREATE TABLE IF NOT EXISTS $taskTable ('
      ' $taskId INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,'
      ' $taskDescription TEXT NOT NULL,'
      ' $taskIsDone INTEGER DEFAULT 0'
      ')',
    );
  }

  Future<void> _dropTables() async {
    try {
      Batch batch = _db.batch();
      // Tables
      _dropTaskTable(batch);
      // Commit tables
      await batch.commit();
    } catch (err) {
      log('Database drop error: $err');
    }
  }

  void _dropTaskTable(Batch batch) {
    batch.execute(
      'DROP TABLE IF EXISTS $taskTable',
    );
  }

  // ----------------------------------
  //          Tables Methods
  // ----------------------------------
  // taskTable
  @override
  Future<int> insertTask(Map<String, Object?> taskMap) async {
    if (!_db.isOpen) await _openDatabase();
    try {
      final result = await _db.insert(
        taskTable,
        taskMap,
        conflictAlgorithm: ConflictAlgorithm.abort,
      );
      return result;
    } catch (err) {
      log('insertTask error: $err');
      return -1;
    }
  }

  @override
  Future<List<Map<String, Object?>?>?> queryTasks() async {
    if (!_db.isOpen) await _openDatabase();
    try {
      final result = await _db.query(
        taskTable,
      );
      if (result.isEmpty) return [];
      return result;
    } catch (err) {
      log('queryTaskId error: $err');
      return null;
    }
  }

  @override
  Future<Map<String, Object?>?> queryTaskId(int id) async {
    if (!_db.isOpen) await _openDatabase();
    try {
      final result = await _db.query(
        taskTable,
        where: '$taskId = ?',
        whereArgs: [id],
      );
      if (result.isEmpty) return {};
      return result.first;
    } catch (err) {
      log('queryTaskId error: $err');
      return null;
    }
  }

  @override
  Future<int> updateTask(Map<String, Object?> taskMap) async {
    if (!_db.isOpen) await _openDatabase();
    try {
      final id = taskMap[taskId];
      if (id == null) {
        throw Exception('the task has not $taskId');
      }
      final result = await _db.update(
        taskTable,
        taskMap,
        where: '$taskId = ?',
        whereArgs: [id],
      );
      if (result != 1) {
        throw Exception('_db.update return $result');
      }
      return result;
    } catch (err) {
      log('updateTask error: $err');
      return -1;
    }
  }

  @override
  Future<int> updateTaskIsDone(int id, bool isDone) async {
    if (!_db.isOpen) _openDatabase();
    try {
      final result = await _db.update(
        taskTable,
        {taskIsDone: isDone ? 1 : 0},
        where: '$taskId = ?',
        whereArgs: [id],
      );
      if (result != 1) {
        throw Exception('_db.update retirn $result');
      }
      return result;
    } catch (err) {
      log('updateTask error: $err');
      return -1;
    }
  }

  @override
  Future<int> deleteTask(int id) async {
    if (!_db.isOpen) _openDatabase();
    try {
      final result = await _db.delete(
        taskTable,
        where: '$taskId = ?',
        whereArgs: [id],
      );
      if (result != 1) {
        throw Exception('_db.delete retirn $result');
      }
      return result;
    } catch (err) {
      log('updateTask error: $err');
      return -1;
    }
  }
}
