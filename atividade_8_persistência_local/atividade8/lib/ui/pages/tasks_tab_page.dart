import 'package:flutter/material.dart';

import '../../viewmodels/tasks_viewmodel.dart';
import '../widgets/task_item_tile.dart';

class TasksTabPage extends StatefulWidget {
  final TasksViewModel viewModel;

  const TasksTabPage({super.key, required this.viewModel});

  @override
  State<TasksTabPage> createState() => _TasksTabPageState();
}

class _TasksTabPageState extends State<TasksTabPage> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final vm = widget.viewModel;

    return AnimatedBuilder(
      animation: vm,
      builder: (_, __) {
        if (vm.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // Campo de texto + botão ADD
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      decoration: const InputDecoration(
                        labelText: "Nova tarefa",
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () {
                      vm.addTask(_controller.text);
                      _controller.clear();
                    },
                    child: const Icon(Icons.add),
                  )
                ],
              ),

              const SizedBox(height: 20),

              // Lista de tarefas
              Expanded(
                child: vm.tasks.isEmpty
                    ? const Center(child: Text("Nenhuma tarefa"))
                    : ListView.builder(
                        itemCount: vm.tasks.length,
                        itemBuilder: (_, i) {
                          final task = vm.tasks[i];
                          return TaskItemTile(
                            task: task,
                            onToggle: () => vm.toggleTask(task),
                            onDelete: () => vm.deleteTask(task),
                          );
                        },
                      ),
              ),

              // Botão limpar tudo
              ElevatedButton.icon(
                onPressed: vm.clearAll,
                icon: const Icon(Icons.delete_forever),
                label: const Text("Limpar tudo"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
