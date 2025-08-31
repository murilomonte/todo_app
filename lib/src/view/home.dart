// ignore: unused_import
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/src/provider/todo_provider.dart';
import 'package:todo_app/src/view/add_task.dart';
import 'package:todo_app/src/widget/task_item.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ToDo app', style: GoogleFonts.getFont('Lato')),
      ),
      body: Consumer<TodoProvider>(
        builder: (context, value, child) {
          if (value.isLoading) {
            return Center(child: CircularProgressIndicator());
          }

          if (value.taskList.isEmpty) {
            return Center(child: Text('There are no tasks yet. Click the + to add one!'),);
          }

          return ListView.builder(
            itemCount: value.taskList.length,
            itemBuilder: (context, index) {
              return TaskItem(
                id: value.taskList[index].id,
                title: value.taskList[index].title,
                status: value.taskList[index].status,
                onLongPress: (id) {
                  context.read<TodoProvider>().deleteTask(id);
                },
                onCheck: (id, status) {
                  context.read<TodoProvider>().updateTaskStatus(
                    id,
                    status ? false : true,
                  );
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        shape: CircleBorder(),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddTask()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
