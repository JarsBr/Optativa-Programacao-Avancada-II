import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app.dart';
import 'data/datasources/tasks_file_storage.dart';
import 'data/datasources/tasks_prefs_storage.dart';
import 'data/datasources/tasks_sqlite_storage.dart';
import 'data/repositories/tasks_repository.dart';
import 'viewmodels/tasks_viewmodel.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MultiProvider(
      providers: [
        Provider<List<TasksViewModel>>(
          create: (_) {
            final vmPrefs = TasksViewModel(
              repository: TasksRepository(storage: TasksPrefsStorage()),
            );
            final vmFile = TasksViewModel(
              repository: TasksRepository(storage: TasksFileStorage()),
            );
            final vmSqlite = TasksViewModel(
              repository: TasksRepository(storage: TasksSqliteStorage()),
            );

            vmPrefs.loadTasks();
            vmFile.loadTasks();
            vmSqlite.loadTasks();

            return [vmPrefs, vmFile, vmSqlite];
          },
        ),
      ],
      child: const MyApp(),
    ),
  );
}
