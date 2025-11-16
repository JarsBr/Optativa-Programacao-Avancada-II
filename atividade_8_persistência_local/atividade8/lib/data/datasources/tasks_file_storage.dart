import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

import '../../models/task.dart';
import 'tasks_storage.dart';

class TasksFileStorage implements TasksStorage {
  Future<File> get _file async {
    final dir = await getApplicationDocumentsDirectory();
    final filePath = path.join(dir.path, 'tasks.json');
    return File(filePath);
  }

  @override
  Future<List<Task>> loadTasks() async {
    try {
      final file = await _file;

      if (!(await file.exists())) {
        return [];
      }

      final jsonString = await file.readAsString();
      final List<dynamic> data = jsonDecode(jsonString);

      return data.map((e) => Task.fromJson(e)).toList();
    } catch (e) {
      return [];
    }
  }

  @override
  Future<void> addTask(Task task) async {
    final tasks = await loadTasks();

    // Gerando ID assim como na versão SharedPreferences
    final newId =
        tasks.isEmpty ? 1 : (tasks.map((t) => t.id ?? 0).reduce((a, b) => a > b ? a : b) + 1);

    tasks.add(task.copyWith(id: newId));

    await _save(tasks);
  }

  @override
  Future<void> updateTask(Task task) async {
    final tasks = await loadTasks();

    final index = tasks.indexWhere((t) => t.id == task.id);
    if (index == -1) return;

    tasks[index] = task;

    await _save(tasks);
  }

  @override
  Future<void> deleteTask(int id) async {
    final tasks = await loadTasks();

    tasks.removeWhere((t) => t.id == id);

    await _save(tasks);
  }

  @override
  Future<void> deleteAll() async {
    final file = await _file;

    if (await file.exists()) {
      await file.delete();
    }
  }

  // ---- Função privada para salvar lista ----
  Future<void> _save(List<Task> tasks) async {
    final file = await _file;

    final listMap = tasks.map((t) => t.toJson()).toList();
    final jsonString = jsonEncode(listMap);

    await file.writeAsString(jsonString);
  }
}
