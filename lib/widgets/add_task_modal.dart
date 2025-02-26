import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_provider/providers/todo_provider.dart';

class AddTaskModal extends StatefulWidget {
  const AddTaskModal({super.key});

  @override
  State<AddTaskModal> createState() => _AddTaskModalState();
}

class _AddTaskModalState extends State<AddTaskModal> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _controller.text = '';
    // key que identifica unicamente o formulário
    final formKey = GlobalKey<FormState>();

    return Dialog(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Add task',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 10),

                TextFormField(
                  autofocus: true,
                  controller: _controller,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text('Task name'),
                  ),
                  validator: (value) {
                    // validação que retorna uma mensagem ao usuário
                    if (value == null || value.isEmpty) {
                      return 'Add task name';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                Row(
                  spacing: 10,
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        style: OutlinedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 25),
                        ),
                        onPressed: () => Navigator.pop(context),
                        icon: Icon(Icons.close),
                        label: Text('Close'),
                      ),
                    ),
                    Expanded(
                      child: FilledButton.icon(
                        style: FilledButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 25),
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
                            final todo = context.read<TodoProvider>();
                            todo.addTask(_controller.text);
                            Navigator.pop(context);
                          }
                        },
                        icon: Icon(Icons.add),
                        label: Text('Add'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
