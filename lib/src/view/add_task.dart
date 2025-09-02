import 'dart:developer';

import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/src/data/database/app_database.dart';
import 'package:todo_app/src/provider/todo_provider.dart';

class AddTask extends StatefulWidget {
  const AddTask({super.key});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  final _taskTitle = TextEditingController();
  final _addTaskForm = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add task')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _addTaskForm,
            child: Column(
              spacing: 10,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Title', style: TextStyle(fontSize: 20)),
                TextFormField(
                  controller: _taskTitle,
                  decoration: InputDecoration(border: OutlineInputBorder()),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Add task name';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      resizeToAvoidBottomInset: true,
      bottomSheet: BottomAppBar(
        color: Colors.transparent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TextButton.icon(
              style: ButtonStyle(
                fixedSize: WidgetStatePropertyAll(Size(100, 100)),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
              label: Text('Cancel'),
              icon: Icon(Icons.close),
            ),
            TextButton.icon(
              style: ButtonStyle(
                fixedSize: WidgetStatePropertyAll(Size(100, 100)),
              ),
              onPressed: () async {
                if (_addTaskForm.currentState!.validate()) {
                  try {
                    await context.read<TodoProvider>().addTask(
                      TasksCompanion(
                        title: Value(_taskTitle.text),
                        status: Value(false),
                      ),
                    );
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Task adicionada!')),
                      );
                      Navigator.pop(context);
                    }
                  } catch (err) {
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Não foi possível adicionar a task.'),
                        ),
                      );
                    }
                  }
                }
              },
              label: Text('Add'),
              icon: Icon(Icons.add),
            ),
          ],
        ),
      ),
    );
  }
}
