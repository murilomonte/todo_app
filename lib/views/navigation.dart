import 'package:flutter/material.dart';
import 'package:todo_provider/views/home_page.dart';
import 'package:todo_provider/views/profile_page.dart';

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
        destinations: [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outlined),
            selectedIcon: Icon(Icons.person),
            label: 'Profile',
          )
        ],
      ),
      body: [HomePage(), ProfilePage()][counter],
    );
  }
}
