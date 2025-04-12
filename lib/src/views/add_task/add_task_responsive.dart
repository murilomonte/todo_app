import 'package:flutter/material.dart';
import 'package:todo_provider/src/utility/constraints.dart';
import 'package:todo_provider/src/views/add_task/add_task_desktop.dart';
import 'package:todo_provider/src/views/add_task/add_task_mobile.dart';

class AddTaskResponsive extends StatelessWidget {
  const AddTaskResponsive({super.key});
  // TODO: eliminar a reduncância das interfaces responsivas
  // - Talvez seja possível transformando a parte do widget constante em um método do próprio widget, e posteriormente utilizando um layout builder para reconstruir o widget pai.
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (isMobileLayout(context)) {
          return AddTaskMobile(); // -> Dialog.fullscreen
        }
        return AddTaskDesktop(); // -> Dialog
      },
    );
  }
}
