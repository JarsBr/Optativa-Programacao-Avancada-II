import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../viewmodels/tasks_viewmodel.dart';
import 'tasks_tab_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModels = Provider.of<List<TasksViewModel>>(context);

    final vmPrefs  = viewModels[0]; // SharedPreferences
    final vmFile   = viewModels[1]; // File
    final vmSqlite = viewModels[2]; // SQLite

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("MyTasks"),
          bottom: const TabBar(
            tabs: [
              Tab(text: "SharedPrefs"),
              Tab(text: "File"),
              Tab(text: "SQLite"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            TasksTabPage(viewModel: vmPrefs),
            TasksTabPage(viewModel: vmFile),
            TasksTabPage(viewModel: vmSqlite),
          ],
        ),
      ),
    );
  }
}
