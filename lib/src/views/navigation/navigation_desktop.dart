import 'package:flutter/material.dart';
import 'package:todo_provider/src/views/home_page.dart';
import 'package:todo_provider/src/views/progress_page.dart';
import 'package:todo_provider/src/views/settings_page.dart';

class NavigationDesktop extends StatefulWidget {
  const NavigationDesktop({super.key});

  @override
  State<NavigationDesktop> createState() => _NavigationDesktopState();
}

class _NavigationDesktopState extends State<NavigationDesktop> {
  int selectedIndex = 0;

  void changeIndex(value) {
    setState(() {
      selectedIndex = value;
    });
  }

  @override
  Widget build(BuildContext context) {
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
          child: [HomePage(), ProgressPage(), SettingsPage()][selectedIndex],
        ),
      ],
    );
  }
}
