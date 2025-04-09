
import 'package:flutter/material.dart';
import 'package:todo_provider/src/views/add_task/add_task_desktop.dart';
import 'package:todo_provider/src/views/add_task/add_task_mobile.dart';

class AddTaskResponsive extends StatelessWidget {
  const AddTaskResponsive({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Widget para controlar o responsivo da página
        if (constraints.maxWidth < 500 ) {
          return AddTaskMobile(); // -> Scaffold
        }
        return AddTaskDesktop(); // -> Dialog
      },
    );
  }
}
