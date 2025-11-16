import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../models/task.dart';
import 'tasks_storage.dart';

class TasksPrefsStorage implements TasksStorage {
  static const String key = "tasks_prefs_list";

  Future<SharedPreferences> get _prefs async =>
      await SharedPreferences.getInstance();

  @override
  Future<List<Task>> loadTasks() async {
    final prefs = await _prefs;
    final jsonString = prefs.getString(key);

    // Nunca salvou nada ainda
    if (jsonString == null || jsonString.isEmpty) {
      return [];
    }

    try {
      final List<dynamic> data = jsonDecode(jsonString);
      return data
          .map((e) => Task.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (e) {
      // Se der problema no parse, evita quebrar o app
      return [];
    }
  }

  @override
  Future<void> addTask(Task task) async {
    final tasks = await loadTasks();

    final int newId = tasks.isEmpty
        ? 1
        : (tasks.map((t) => t.id ?? 0).reduce((a, b) => a > b ? a : b) + 1);

    final newTask = task.copyWith(id: newId);

    tasks.add(newTask);
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
    final prefs = await _prefs;
    await prefs.remove(key);
  }

  Future<void> _save(List<Task> tasks) async {
    final prefs = await _prefs;

    final listMap = tasks.map((t) => t.toJson()).toList();
    final jsonString = jsonEncode(listMap);

    await prefs.setString(key, jsonString);
  }
}
