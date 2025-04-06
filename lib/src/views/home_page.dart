import 'package:flutter/material.dart';
import 'package:todo_provider/src/views/add_task_page.dart';
import 'package:todo_provider/src/widgets/task_tab.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 700) {
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AddtaskPage()),
                  );
                },
                label: Text('Add task'),
                icon: Icon(Icons.add),
              ),
            ),
          );
        }
        return Scaffold(
          appBar: AppBar(title: Text('Todo App')),
          body: Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Row(
                        spacing: 10,
                        children: [
                          Icon(
                            Icons.list,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          Text(
                            'Pending',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(child: TaskTab(pending: true, title: 'Pending')),
                  ],
                ),
              ),
              VerticalDivider(),
              Expanded(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Row(
                        spacing: 10,
                        children: [
                          Icon(
                            Icons.checklist,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          Text(
                            'Completed',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: TaskTab(pending: false, title: 'Completed'),
                    ),
                  ],
                ),
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddtaskPage()),
              );
            },
            label: Text('Add task'),
            icon: Icon(Icons.add),
          ),
        );
      },
    );
  }
}
