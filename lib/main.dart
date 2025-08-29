import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/src/provider/todo_provider.dart';
import 'package:todo_app/src/todo_app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => TodoProvider())],
      child: TodoApp(),
    ),
  );
}
