import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restart_app/restart_app.dart';
import 'package:todo_provider/src/controllers/theme_controller.dart';
import 'package:todo_provider/src/controllers/user_controller.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Settings')),
      body: Align(
        alignment: Alignment.topCenter,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: 700
          ),
          child: SingleChildScrollView(
            child: Padding(
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
                  Consumer<ThemeController>(
                    builder: (context, value, child) {
                      return InkWell(
                        customBorder: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
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
                    customBorder: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text('Are you sure?'),
                            content: Text(
                              'This is irreversible and will delete all user data.',
                            ),
                            actions: [
                              OutlinedButton.icon(
                                style: OutlinedButton.styleFrom(
                                  padding: EdgeInsets.symmetric(
                                    vertical: 15,
                                    horizontal: 20,
                                  ),
                                ),
                                onPressed: () {
                                  Provider.of<UserController>(
                                    context,
                                    listen: false,
                                  ).resetUserData();
                                  Restart.restartApp(
                                    notificationTitle: 'Restarting App',
                                    notificationBody:
                                        'Please tap here to open the app again.',
                                  );
                                },
                                icon: Icon(Icons.check),
                                label: Text('Yes'),
                              ),
                              FilledButton.icon(
                                style: FilledButton.styleFrom(
                                  padding: EdgeInsets.symmetric(
                                    vertical: 15,
                                    horizontal: 20,
                                  ),
                                ),
                                onPressed: () => Navigator.of(context).pop(),
                                icon: Icon(Icons.close),
                                label: Text('No'),
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
          ),
        ),
      ),
    );
  }
}
