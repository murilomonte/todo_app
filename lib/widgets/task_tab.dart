import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_provider/providers/todo_provider.dart';

class TaskTab extends StatelessWidget {
  final bool pending;
  final String title;
  const TaskTab({super.key, required this.pending, required this.title});

  @override
  Widget build(BuildContext context) {
    // Guarda uma instância de TodoProvider
    TodoProvider todoProvider = context.watch<TodoProvider>();
    // Define qual lista usar dependendo do caso
    List tasks =
        pending ? todoProvider.pendingTasks : todoProvider.completedTasks;

    if (tasks.isEmpty) {
      return Center(child: Text('Add some tasks!'));
    }
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 5,
        children: [
          SizedBox(height: 10),
          // Task list
          Expanded(
            // Constrói uma lista de itens com base na lista de tasks
            child: ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    title: Text(tasks[index].name),
                    trailing: Checkbox(
                      value: tasks[index].completed,
                      onChanged: (value) => todoProvider.toggleTask(index, tasks[index].id)
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}