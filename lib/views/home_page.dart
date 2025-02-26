import 'package:flutter/material.dart';
import 'package:todo_provider/views/add_task_page.dart';
import 'package:todo_provider/widgets/task_tab.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

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
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => AddtaskPage(),));
          },
          label: Text('Add task'),
          icon: Icon(Icons.add),
        ),
      ),
    );
  }
}
