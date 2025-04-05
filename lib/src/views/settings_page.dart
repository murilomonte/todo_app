import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restart_app/restart_app.dart';
import 'package:todo_provider/src/providers/theme_provider.dart';
import 'package:todo_provider/src/providers/user_provider.dart';

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
            // Tema
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text('Theme settings', style: TextStyle(fontSize: 17)),
            ),
            SizedBox(height: 10),
            Consumer<ThemeProvider>(
              builder: (context, value, child) {
                return InkWell(
                  radius: 15,
                  onTap: () => value.toggleTheme(),
                  child: Card.filled(
                    margin: EdgeInsets.all(0),
                    // color: Theme.of(context).colorScheme.surfaceContainer,
                    child: SizedBox(
                      height: 70,
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
                  ),
                );
              },
            ),
            SizedBox(height: 20),

            // Dados
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text('User data', style: TextStyle(fontSize: 17)),
            ),
            SizedBox(height: 10),
            InkWell(
              radius: 15,
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text('Are you shure?'),
                      content: Text(
                        'This is irreversible and will delete all user data.',
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Provider.of<UserProvider>(
                              context,
                              listen: false,
                            ).resetUserData();
                            Restart.restartApp(
                              notificationTitle: 'Restarting App',
                              notificationBody:
                                  'Please tap here to open the app again.',
                            );
                          },
                          child: Text('Yes'),
                        ),
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: Text('No'),
                        ),
                      ],
                    );
                  },
                );
              },
              child: Card.filled(
                margin: EdgeInsets.all(0),
                // color: Theme.of(context).colorScheme.surfaceContainer,
                child: SizedBox(
                  height: 70,
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
                            Icon(Icons.delete, size: 20),
                            Text('Delete all user data'),
                          ],
                        ),
                        Icon(Icons.chevron_right_outlined),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
