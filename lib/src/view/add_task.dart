import 'package:flutter/material.dart';

class AddTask extends StatelessWidget {
  const AddTask({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add task')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            spacing: 10,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Title', style: TextStyle(fontSize: 20),),
              TextField(
                decoration: InputDecoration(border: OutlineInputBorder()),
              ),
            ],
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
              onPressed: () {},
              label: Text('Add'),
              icon: Icon(Icons.add),
            ),
          ],
        ),
      ),
    );
  }
}
