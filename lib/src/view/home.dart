// ignore: unused_import
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/src/provider/todo_provider.dart';
import 'package:todo_app/src/view/add_task.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<TodoProvider>().updateTaskList();
    return Scaffold(
      appBar: AppBar(
        title: Text('ToDo app', style: GoogleFonts.getFont('Lato')),
      ),
      body: Consumer<TodoProvider>(
        builder: (context, value, child) {
          return ListView.builder(
            itemCount: value.taskList.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(
                  value.taskList[index].title,
                  style: GoogleFonts.getFont('Lato'),
                ),
                trailing: Checkbox(value: false, onChanged: (value) {}),
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
