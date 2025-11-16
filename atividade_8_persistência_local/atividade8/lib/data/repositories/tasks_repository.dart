import '../../models/task.dart';
import '../datasources/tasks_storage.dart';

class TasksRepository {
  final TasksStorage storage;

  TasksRepository({required this.storage});

  Future<List<Task>> getTasks() async {
    return await storage.loadTasks();
  }

  Future<void> createTask(String title) async {
    final newTask = Task(title: title, done: false);
    await storage.addTask(newTask);
  }

  Future<void> toggleDone(Task task) async {
    final updated = task.copyWith(done: !task.done);
    await storage.updateTask(updated);
  }

  Future<void> updateTask(Task task) async {
    await storage.updateTask(task);
  }

  Future<void> removeTask(Task task) async {
    if (task.id != null) {
      await storage.deleteTask(task.id!);
    }
  }

  Future<void> clearAll() async {
    await storage.deleteAll();
  }
}
