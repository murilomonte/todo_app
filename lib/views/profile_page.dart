import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_provider/providers/todo_provider.dart';
import 'package:todo_provider/views/settings_page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        actions: [
          IconButton(
            onPressed:
                () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SettingsPage()),
                ),
            icon: Icon(Icons.settings_outlined),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Info perfil
            Row(
              spacing: 20,
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(
                    'https://i.pinimg.com/originals/b3/2e/df/b32edfb7da5ef8d5e85740b3100b1b2f.jpg',
                  ),
                  radius: 60,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Fulaninho', style: TextStyle(fontSize: 30)),
                    Text('@catWithTie', style: TextStyle(fontSize: 15)),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20),
            Text('Progress', style: TextStyle(fontSize: 25)),
            SizedBox(height: 10),
            Card.filled(
              margin: EdgeInsets.all(0),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 22,
                  horizontal: 20,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      spacing: 5,
                      children: [Icon(Icons.paid_outlined), Text('Pontuação')],
                    ),
                    Text(
                      '${context.watch<TodoProvider>().points.round().toString()}pts',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10),
            // Card.filled(
            //   margin: EdgeInsets.all(0),
            //   child: Padding(
            //     padding: const EdgeInsets.symmetric(
            //       vertical: 15,
            //       horizontal: 20,
            //     ),
            //     child: Row(
            //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //       children: [
            //         Row(
            //           spacing: 5,
            //           children: [
            //             Icon(Icons.event_available_outlined),
            //             Text('Daily goal'),
            //           ],
            //         ),
            //         CircularProgressIndicator(
            //           // ignore: deprecated_member_use
            //           year2023: false,
            //           value: 0.63,
            //           backgroundColor: Colors.amber,
            //           padding: EdgeInsets.all(0),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
