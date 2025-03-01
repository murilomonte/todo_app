import 'package:flutter/material.dart';
import 'package:todo_provider/src/views/home_page.dart';
import 'package:todo_provider/src/views/progress_page.dart';

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
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          // indicatorColor: const Color.fromARGB(255, 50, 50, 50) -> mudar depois
        ),
        child: NavigationBar(
          //labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
          onDestinationSelected: (value) {
            setState(() {
              counter = value;
            });
          },
          indicatorShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          selectedIndex: counter,
          labelPadding: EdgeInsets.all(1),
          destinations: [
            NavigationDestination(
              icon: Icon(Icons.home_outlined),
              selectedIcon: Icon(Icons.home),
              label: 'Home',
            ),
            NavigationDestination(
              selectedIcon: Icon(Icons.trending_up),
              icon: Icon(Icons.trending_up_outlined),
              label: 'Score',
            ),
          ],
        ),
      ),
      body: [HomePage(), ProgressPage()][counter],
    );
  }
}
