import 'package:flutter/material.dart';
import 'package:todo_provider/src/views/home_page.dart';
import 'package:todo_provider/src/views/progress_page.dart';
import 'package:todo_provider/src/views/settings_page.dart';

class NavigationMobile extends StatefulWidget {
  const NavigationMobile({super.key});

  @override
  State<NavigationMobile> createState() => _NavigationMobileState();
}

class _NavigationMobileState extends State<NavigationMobile> {
  int selectedIndex = 0;

  void changeIndex(value) {
    setState(() {
      selectedIndex = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (value) => changeIndex(value),
        height: 70,
        indicatorShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        selectedIndex: selectedIndex,
        labelPadding: EdgeInsets.all(1),
        destinations: [
          NavigationDestination(
            icon: Icon(Icons.checklist),
            selectedIcon: Icon(Icons.checklist_outlined),
            label: 'Tasks',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.trending_up),
            icon: Icon(Icons.trending_up_outlined),
            label: 'Score',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.settings),
            icon: Icon(Icons.settings_outlined),
            label: 'Settings',
          ),
          
        ],
      ),
      body: [HomePage(), ProgressPage(), SettingsPage()][selectedIndex],
    );
  }
}
