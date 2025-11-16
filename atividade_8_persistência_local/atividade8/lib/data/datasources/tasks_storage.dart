import '../../models/task.dart';

abstract class TasksStorage {
  Future<List<Task>> loadTasks();
  Future<void> addTask(Task task);
  Future<void> updateTask(Task task);
  Future<void> deleteTask(int id);
  Future<void> deleteAll();
}
