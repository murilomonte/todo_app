import 'package:flutter/material.dart';
import 'package:todo_provider/views/home_page.dart';
import 'package:todo_provider/views/settings_page.dart';

class Navigation extends StatefulWidget {
  const Navigation({super.key});

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  int counter = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (value) {
          setState(() {
            counter = value;
          });
        },
        selectedIndex: counter,
        destinations: [
          NavigationDestination(icon: Icon(Icons.home_outlined) , selectedIcon: Icon(Icons.home), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.settings_outlined) , selectedIcon: Icon(Icons.settings), label: 'Settings'),
        ],
      ),
      body: [
        HomePage(),
        SettingsPage(),
      ][counter],
    );
  }
}
