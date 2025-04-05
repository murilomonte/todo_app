import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_provider/src/providers/user_provider.dart';

class ProgressPage extends StatelessWidget {
  const ProgressPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Progress'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                    Consumer<UserProvider>(builder: (context, value, child) {
                      return Text(
                          '${value.user!.score.round().toString()}pts',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        );
                    },)
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
