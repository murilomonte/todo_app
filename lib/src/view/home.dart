import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app/src/view/add_task.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ToDo app', style: GoogleFonts.getFont('Lato')),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text('Task name', style: GoogleFonts.getFont('Lato')),
            trailing: Checkbox(value: false, onChanged: (value) {}),
          ),
          ListTile(
            title: Text('Task name', style: GoogleFonts.getFont('Lato')),
            trailing: Checkbox(value: false, onChanged: (value) {}),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        shape: CircleBorder(),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddTask()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
