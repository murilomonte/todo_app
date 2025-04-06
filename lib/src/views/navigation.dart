import 'package:flutter/material.dart';
import 'package:todo_provider/src/views/home_page.dart';
import 'package:todo_provider/src/views/progress_page.dart';
import 'package:todo_provider/src/views/settings_page.dart';

class Navigation extends StatefulWidget {
  const Navigation({super.key});

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  int selectedIndex = 0;

  void changeIndex(value) {
    setState(() {
      selectedIndex = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 500) {
          return Scaffold(
            bottomNavigationBar: NavigationBarTheme(
              data: NavigationBarThemeData(
                // indicatorColor: const Color.fromARGB(255, 50, 50, 50) -> mudar depois
              ),
              child: NavigationBar(
                //labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
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
            ),
            body: [HomePage(), ProgressPage(), SettingsPage()][selectedIndex],
          );
        }
        return Row(
          children: [
            NavigationRail(
              minWidth: 100,
              indicatorShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              labelType: NavigationRailLabelType.all,
              destinations: [
                NavigationRailDestination(
                  icon: Icon(Icons.checklist),
                  selectedIcon: Icon(Icons.checklist_outlined),
                  label: Text('Tasks'),
                ),
                NavigationRailDestination(
                  selectedIcon: Icon(Icons.trending_up),
                  icon: Icon(Icons.trending_up_outlined),
                  label: Text('Score'),
                ),
                NavigationRailDestination(
                  selectedIcon: Icon(Icons.settings),
                  icon: Icon(Icons.settings_outlined),
                  label: Text('Settings'),
                ),
              ],
              selectedIndex: selectedIndex,
              onDestinationSelected: (value) => changeIndex(value),
            ),
            Expanded(
              child:
                  [HomePage(), ProgressPage(), SettingsPage()][selectedIndex],
            ),
          ],
        );
      },
    );
  }
}
