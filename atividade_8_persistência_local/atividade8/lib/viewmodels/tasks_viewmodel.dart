import 'package:flutter/material.dart';

import '../data/repositories/tasks_repository.dart';
import '../models/task.dart';

class TasksViewModel extends ChangeNotifier {
  final TasksRepository repository;

  TasksViewModel({required this.repository});

  List<Task> _tasks = [];
  List<Task> get tasks => _tasks;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _error;
  String? get error => _error;

  // ---- Função para carregar tarefas ----
  Future<void> loadTasks() async {
    _setLoading(true);

    try {
      _tasks = await repository.getTasks();
      _error = null;
    } catch (e) {
      _error = "Erro ao carregar tarefas";
    }

    _setLoading(false);
  }

  // ---- Criar nova tarefa ----
  Future<void> addTask(String title) async {
    if (title.trim().isEmpty) return;

    _setLoading(true);

    try {
      await repository.createTask(title);
      await loadTasks(); // recarrega após salvar
    } catch (e) {
      _error = "Erro ao adicionar tarefa";
      _setLoading(false);
    }

    notifyListeners();
  }

  // ---- Alternar concluída/não concluída ----
  Future<void> toggleTask(Task task) async {
    try {
      await repository.toggleDone(task);
      await loadTasks();
    } catch (e) {
      _error = "Erro ao atualizar tarefa";
    }
    notifyListeners();
  }

  // ---- Excluir tarefa ----
  Future<void> deleteTask(Task task) async {
    try {
      await repository.removeTask(task);
      await loadTasks();
    } catch (e) {
      _error = "Erro ao excluir tarefa";
    }
    notifyListeners();
  }

  // ---- Limpar todas ----
  Future<void> clearAll() async {
    try {
      await repository.clearAll();
      await loadTasks();
    } catch (e) {
      _error = "Erro ao limpar tarefas";
    }
    notifyListeners();
  }

  // ---- Helper para indicar carregamento ----
  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}
