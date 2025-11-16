import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;

import '../../models/task.dart';
import 'tasks_storage.dart';

class TasksSqliteStorage implements TasksStorage {
  static const _dbName = "tasks.db";
  static const _tableName = "tasks";

  Future<Database> get _db async {
    final dbPath = await getDatabasesPath();
    final path = p.join(dbPath, _dbName);

    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE $_tableName (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT,
            done INTEGER
          )
        ''');
      },
    );
  }

  @override
  Future<List<Task>> loadTasks() async {
    final db = await _db;

    final result = await db.query(_tableName);

    return result
        .map((row) => Task(
              id: row['id'] as int,
              title: row['title'] as String,
              done: (row['done'] as int) == 1,
            ))
        .toList();
  }

  @override
  Future<void> addTask(Task task) async {
    final db = await _db;

    await db.insert(
      _tableName,
      {
        "title": task.title,
        "done": task.done ? 1 : 0,
      },
    );
  }

  @override
  Future<void> updateTask(Task task) async {
    final db = await _db;

    await db.update(
      _tableName,
      {
        "title": task.title,
        "done": task.done ? 1 : 0,
      },
      where: "id = ?",
      whereArgs: [task.id],
    );
  }

  @override
  Future<void> deleteTask(int id) async {
    final db = await _db;

    await db.delete(
      _tableName,
      where: "id = ?",
      whereArgs: [id],
    );
  }

  @override
  Future<void> deleteAll() async {
    final db = await _db;

    await db.delete(_tableName);
  }
}
