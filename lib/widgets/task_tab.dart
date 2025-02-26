import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_provider/providers/todo_provider.dart';
import 'package:todo_provider/widgets/task_info_bottom_sheet.dart';

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
      padding: const EdgeInsets.symmetric(horizontal: 15),
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
                return TaskItem(
                  tasks: tasks,
                  todoProvider: todoProvider,
                  index: index,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class TaskItem extends StatelessWidget {
  const TaskItem({
    super.key,
    required this.tasks,
    required this.todoProvider,
    required this.index,
  });

  final List tasks;
  final TodoProvider todoProvider;
  final int index;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      radius: 15,
      onTap: () {
        showModalBottomSheet(
          showDragHandle: true,
          context: context,
          useRootNavigator: true,
          useSafeArea: true,
          isScrollControlled: true,
          builder: (BuildContext context) {
            return TaskInfoBottomSheet(
              tasks: tasks,
              index: index,
              todoProvider: todoProvider,
            );
          },
        );
      },
      child: Card.filled(
        margin: EdgeInsets.all(0),
        color: Theme.of(context).colorScheme.surfaceContainer,
        child: ListTile(
          // leading: Icon(Icons.task_alt),
          title: Text(tasks[index].name),
          subtitle:
              tasks[index].description != ''
                  ? Text(
                    tasks[index].description,
                    style: TextStyle(fontSize: 11),
                    overflow: TextOverflow.ellipsis,
                  )
                  : Text('Click to show info', style: TextStyle(fontSize: 11)),
          trailing: Checkbox(
            value: tasks[index].completed,
            onChanged:
                (value) => todoProvider.toggleTask(index, tasks[index].id),
          ),
        ),
      ),
    );
  }
}
