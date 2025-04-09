import 'package:flutter/material.dart';
import 'package:todo_provider/src/views/navigation/navigation_desktop.dart';
import 'package:todo_provider/src/views/navigation/navigation_mobile.dart';

class NavigationResponsive extends StatelessWidget {
  const NavigationResponsive({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth < 500) {
        return NavigationMobile();
      }
      return NavigationDesktop();
    },);
  }
}