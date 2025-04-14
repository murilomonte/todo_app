import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_provider/src/controllers/todo_controller.dart';
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
          constraints: BoxConstraints(maxWidth: 700),
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: 8.0,
                    bottom: 10,
                    top: 10,
                  ),
                  child: Text('Total points', style: TextStyle(fontSize: 17)),
                ),
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
                          children: [
                            Icon(Icons.paid_outlined),
                            Text('Total'),
                          ],
                        ),
                        Consumer<UserController>(
                          builder: (context, value, child) {
                            if (value.user == null) {
                              return Text('');
                            }
                            return Text(
                              '${value.user!.score.round().toString()}pts',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                overflow: TextOverflow.ellipsis,
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                
                Padding(
                  padding: const EdgeInsets.only(
                    left: 8.0,
                    bottom: 10,
                    top: 10,
                  ),

                  child: Text('Categories', style: TextStyle(fontSize: 17)),
                ),
                Expanded(
                  child: Consumer<TodoController>(
                    builder: (context, value, child) {
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: value.categoriesList.length,
                        itemBuilder: (context, index) {
                          return Card.filled(
                            margin: EdgeInsets.only(bottom: 10),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 22,
                                horizontal: 20,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    spacing: 5,
                                    children: [
                                      Icon(Icons.paid_outlined),
                                      Text(value.categoriesList[index].name),
                                    ],
                                  ),
                                  Text(
                                    '${value.categoriesList[index].totalPoints.round()}pts',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
