import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_provider/src/controllers/todo_controller.dart';
import 'package:todo_provider/src/controllers/user_controller.dart';
import 'package:todo_provider/src/widgets/task_info_bottom_sheet.dart';

class TaskItem extends StatelessWidget {
  const TaskItem({
    super.key,
    required this.id,
    required this.title,
    required this.description,
    required this.points,
    required this.status,
  });

  final int id;
  final String title;
  final String description;
  final double points;
  final int status;

  @override
  Widget build(BuildContext context) {
    // usar future builder depois? Ou tentar outra abordagem
    //TodoController TodoController = context.watch<TodoController>();

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: InkWell(
                  customBorder: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        onTap: () {
          showModalBottomSheet(
            showDragHandle: true,
            context: context,
            useRootNavigator: true,
            useSafeArea: true,
            isScrollControlled: true,
            builder: (BuildContext context) {
              return TaskInfoBottomSheet(
                id: id,
                title: title,
                description: description,
                points: points,
                status: status,
              );
            },
          );
        },
        child: Card.filled(
          margin: EdgeInsets.all(0),
          color: Theme.of(context).colorScheme.surfaceContainer,
          child: ListTile(
            // leading: Icon(Icons.task_alt),
            title: Text(title),
            subtitle:
                description != ''
                    ? Text(
                      description,
                      style: TextStyle(fontSize: 11),
                      overflow: TextOverflow.ellipsis,
                    )
                    : Text('Click to show info.', style: TextStyle(fontSize: 11)),
            trailing: Checkbox(
              value: status == 1,
              onChanged: (value) {
                context.read<TodoController>().toggleTask(id, status == 1 ? 0 : 1);
                context.read<UserController>().updateUserScore(points, status);
              },
            ),
          ),
        ),
      ),
    );
  }
}
