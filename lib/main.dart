import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:todo_provider/src/controllers/theme_controller.dart';
import 'package:todo_provider/src/controllers/todo_controller.dart';
import 'package:todo_provider/src/controllers/user_controller.dart';
import 'package:todo_provider/src/views/navigation.dart';

Future main() async {
  // Workaround para permitir que o sqflite funcione em windows e linux
  if (Platform.isWindows || Platform.isLinux) {
    databaseFactory = databaseFactoryFfi;
    sqfliteFfiInit();
  }
  

  WidgetsFlutterBinding.ensureInitialized();
  // make navigation bar transparent
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(systemNavigationBarColor: Colors.transparent),
  );
  // make flutter draw behind navigation bar
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserController()),
        ChangeNotifierProvider(create: (context) => TodoController()),
        ChangeNotifierProvider(create: (context) => ThemeController(context)),
      ],
      child: MyApp()
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: Provider.of<ThemeController>(context).themeData,
        debugShowCheckedModeBanner: false,
        home: Navigation(),
      );
  }
}
