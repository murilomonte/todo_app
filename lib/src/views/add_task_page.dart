import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_provider/src/controllers/todo_controller.dart';

class AddtaskPage extends StatefulWidget {
  const AddtaskPage({super.key});

  @override
  State<AddtaskPage> createState() => _AddtaskPageState();
}

class _AddtaskPageState extends State<AddtaskPage> {
  final TextEditingController _titleController = TextEditingController();

  final TextEditingController _descController = TextEditingController();

  double _points = 0;

  @override
  Widget build(BuildContext context) {
    // key que identifica unicamente o formulário
    final formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(title: Text('Add task')),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Form - Task name e Description
              Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Task name',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5),
                    TextFormField(
                      controller: _titleController,
                      decoration: InputDecoration(
                        hintText: 'Awesome task.',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        // validação que retorna uma mensagem ao usuário
                        if (value == null || value.isEmpty) {
                          return 'Add task name';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Description',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5),
                    TextFormField(
                      controller: _descController,
                      decoration: InputDecoration(
                        hintText: 'Do cool things.',
                        border: OutlineInputBorder(
                          // borderRadius: BorderRadius.all(Radius.circular(20))
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Pontuação
              SizedBox(height: 20),
              Text(
                'Pontuação',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    flex: 8,
                    child: Slider(
                      // ignore: deprecated_member_use
                      year2023: false,
                      value: _points,
                      divisions: 10,
                      max: 100,
                      label: _points.round().toString(),
                      onChanged: (value) {
                        setState(() {
                          _points = value;
                        });
                      },
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      '${_points.toInt()} pts',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Row(
          spacing: 10,
          children: [
            Expanded(
              child: OutlinedButton.icon(
                style: OutlinedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 15),
                ),
                onPressed: () => Navigator.pop(context),
                icon: Icon(Icons.close),
                label: Text('Cancel'),
              ),
            ),
            Expanded(
              child: FilledButton.icon(
                style: FilledButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 15),
                ),
                onPressed: () {
                  // verifica se o campo é válido. Caso contrário, mostra a mensagem de erro
                  if (formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Task added'),
                        behavior: SnackBarBehavior.floating,
                        showCloseIcon: true,
                        duration: Duration(seconds: 2),
                      ),
                    );
                    final todo = context.read<TodoController>();
                    todo.addTask(
                      title: _titleController.text,
                      description: _descController.text,
                      points: _points,
                    );
                    Navigator.pop(context);
                  }
                },
                icon: Icon(Icons.add),
                label: Text('Add'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
