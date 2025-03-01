import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_provider/src/providers/theme_provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Settings')),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Theme settings', style: TextStyle(fontSize: 17)),
            SizedBox(height: 10),
            Consumer<ThemeProvider>(
              builder: (context, value, child) {
                return InkWell(
                  radius: 15,
                  onTap: () => value.toggleTheme(),
                  child: Card.filled(
                    margin: EdgeInsets.all(0),
                    // color: Theme.of(context).colorScheme.surfaceContainer,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 10,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            spacing: 7,
                            children: [
                              Icon(
                                value.isDarkMode
                                    ? Icons.dark_mode
                                    : Icons.light_mode,
                                size: 20,
                              ),
                              Text(
                                value.isDarkMode ? 'Dark mode' : 'Light mode',
                              ),
                            ],
                          ),
                          Switch(
                            value: value.isDarkMode,
                            onChanged: (context) {
                              value.toggleTheme();
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
