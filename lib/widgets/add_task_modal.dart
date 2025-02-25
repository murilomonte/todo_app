import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_provider/providers/todo_provider.dart';

class AddTaskModal extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();
  AddTaskModal({super.key});

  @override
  Widget build(BuildContext context) {
    _controller.text = '';

    return Dialog(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Add task',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 10),

              TextField(
                autofocus: true,
                controller: _controller,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text('Task name'),
                ),
              ),
              SizedBox(height: 10),
              Center(
                child: OutlinedButton(
                  onPressed: () {
                    final todo = context.read<TodoProvider>();
                    todo.addTask(_controller.text);
                    Navigator.pop(context);
                  },
                  child: Text('Add'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
