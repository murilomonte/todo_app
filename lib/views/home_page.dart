import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_provider/providers/todo_provider.dart';

class HomePage extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Todo App'),
          bottom: TabBar(
            tabs: [
              Tab(text: 'Pending', icon: Icon(Icons.list)),
              Tab(text: 'Completed', icon: Icon(Icons.checklist)),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            TaskTab(pending: true, title: 'Pending'),
            TaskTab(pending: false, title: 'Completed'),
          ],
        ),
        floatingActionButton: AddTaskButton(controller: _controller),
      ),
    );
  }
}

class TaskTab extends StatelessWidget {
  final bool pending;
  final String title;
  const TaskTab({super.key, required this.pending, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 5,
        children: [
          // Title
          SizedBox(height: 10),
          Text(
            title,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
          ),

          // Task list
          Expanded(
            child: Consumer<TodoProvider>(
              builder: (context, value, child) {
                if (value.tasks.isEmpty) {
                  return Text('Add some tasks!');
                }
                return ListView.builder(
                  itemCount: value.tasks.length,
                  itemBuilder: (context, index) {
                    if (value.tasks[index].completed != pending) {
                      return Card(
                        child: ListTile(
                          title: Text(value.tasks[index].name),
                          trailing: Checkbox(
                            value: value.tasks[index].completed,
                            onChanged: (valor) {
                              value.markTask(index);
                            },
                          ),
                        ),
                      );
                    }
                    return null;
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

class AddTaskButton extends StatelessWidget {
  const AddTaskButton({super.key, required TextEditingController controller})
    : _controller = controller;

  final TextEditingController _controller;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) {
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
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
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
          },
        );
      },
      label: Text('Add task'),
      icon: Icon(Icons.add),
    );
  }
}
