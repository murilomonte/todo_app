import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_provider/src/controllers/user_controller.dart';

class ProgressPage extends StatelessWidget {
  const ProgressPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Progress'),
      ),
      body: Align(
        alignment: Alignment.topCenter,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: 700
          ),
          child: SingleChildScrollView(
            child: Padding(
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
                          Consumer<UserController>(builder: (context, value, child) {
                            if (value.user == null) {
                              return Text('');
                            }
                            return Text(
                                '${value.user!.score.round().toString()}pts' ,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  overflow: TextOverflow.ellipsis
                                ),
                              );
                          },)
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
