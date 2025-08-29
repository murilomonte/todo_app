import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TaskItem extends StatelessWidget {
  final int id;
  final String title;
  final bool status;
  final Function(int id) onLongPress;
  final Function(int id, bool status) onCheck;
  const TaskItem({
    super.key,
    required this.id,
    required this.title,
    required this.status,
    required this.onLongPress,
    required this.onCheck,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onLongPress: () => onLongPress(id),
      child: ListTile(
        title: Text(title, style: GoogleFonts.getFont('Lato')),
        trailing: Checkbox(value: status, onChanged: (value) => onCheck(id, status)),
      ),
    );
  }
}
