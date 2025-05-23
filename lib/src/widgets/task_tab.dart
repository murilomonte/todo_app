// ignore: unused_import
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_provider/src/models/task_model.dart';
import 'package:todo_provider/src/controllers/todo_controller.dart';
import 'package:todo_provider/src/widgets/task_item.dart';

class TaskTab extends StatelessWidget {
  final bool pending;
  final String title;
  const TaskTab({super.key, required this.pending, required this.title});

  @override
  Widget build(BuildContext context) {
    // Provider.of<TodoController>(context, listen: false).updateTaskList();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 5,
        children: [
          SizedBox(height: 10),
          // Task list
          Expanded(
            child: Consumer<TodoController>(
                builder: (context, value, child) {
                  // log('[run] -> consumer<TodoController>');

                  List<TaskModel> tasks =
                      pending ? value.pendingTasks : value.completedTasks;

                  if (tasks.isEmpty) {
                    return Center(child: Text(pending ? 'Add some tasks!' : 'Complete some tasks!'));        
                  }      

                  // Constrói uma lista de itens com base na lista de tasks
                  return ListView.builder(
                    itemCount: tasks.length,
                    itemBuilder: (context, index) {
                      return TaskItem(
                        id: tasks[index].id,
                        title: tasks[index].title,
                        description: tasks[index].description,
                        points: tasks[index].points,
                        status: tasks[index].status,
                      );
                    },
                  );
                },
              ),
          ),
        ],
      ),
    );
  }
}


  