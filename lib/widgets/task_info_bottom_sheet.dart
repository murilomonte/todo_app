
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_provider/providers/todo_provider.dart';

class TaskInfoBottomSheet extends StatelessWidget {
  const TaskInfoBottomSheet({
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
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(30, 0, 30, 30),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              SizedBox(height: 10),
              if (description != '') Row(
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
              if (description != '') Text(description),
              if (description != '') SizedBox(height: 10),
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
              Text('${points.toInt()} pontos'),
              SizedBox(height: 25),
              Row(
                spacing: 20,
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      style: OutlinedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 15),
                      ),
                      onPressed: () {
                        Provider.of<TodoProvider>(context, listen: false).deleteTask(id);
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
                        Provider.of<TodoProvider>(context, listen: false).toggleTask(id, status == 1 ? 0 : 1);
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
      ),
    );
  }
}