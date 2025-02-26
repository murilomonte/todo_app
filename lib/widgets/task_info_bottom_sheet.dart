
import 'package:flutter/material.dart';
import 'package:todo_provider/providers/todo_provider.dart';

class TaskInfoBottomSheet extends StatelessWidget {
  const TaskInfoBottomSheet({
    super.key,
    required this.tasks,
    required this.index,
    required this.todoProvider,
  });

  final List tasks;
  final int index;
  final TodoProvider todoProvider;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(30, 0, 30, 30),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              tasks[index].name,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            SizedBox(height: 10),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.task_alt_outlined,
                  color: Theme.of(context).colorScheme.primary,
                  size: 18,
                ),
                SizedBox(width: 5),
                Text(
                  'Descrição',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
            Text(tasks[index].description),
            SizedBox(height: 10),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.paid_outlined,
                  color: Theme.of(context).colorScheme.primary,
                  size: 18,
                ),
                SizedBox(width: 5),
                Text(
                  'Pontuação',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
            Text('${tasks[index].points.toInt()} pontos'),
            SizedBox(height: 10),
            Row(
              spacing: 10,
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 15),
                    ),
                    onPressed: () {
                      todoProvider.deleteTask(index, tasks[index].id);
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.close),
                    label: Text('Delete'),
                  ),
                ),
                Expanded(
                  child: FilledButton.icon(
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 15),
                    ),
                    onPressed: () {
                      todoProvider.toggleTask(index, tasks[index].id);
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.task_alt_rounded),
                    label: Text('Mark as done'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
