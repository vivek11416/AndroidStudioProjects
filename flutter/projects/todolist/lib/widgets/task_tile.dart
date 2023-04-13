import 'package:flutter/material.dart';
import 'package:msh_checkbox/msh_checkbox.dart';

class TaskTile extends StatelessWidget {
//   const TaskTile({
//     super.key,
//   });

//   @override
//   State<TaskTile> createState() => _TaskTileState();
// }

// class _TaskTileState extends State<TaskTile> {
  final bool isChecked;
  final String taskTitle;
  final void Function(bool) checkBoxCallback;
  final void Function() longPressCallback;

  TaskTile(
      {this.isChecked = false,
      required this.taskTitle,
      required this.checkBoxCallback,
      required this.longPressCallback});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onLongPress: longPressCallback,
      leading: Text(
        taskTitle,
        style: TextStyle(
          fontSize: 25,
          decoration: isChecked ? TextDecoration.lineThrough : null,
        ),
      ),
      trailing: MSHCheckbox(
        size: 25,
        value: isChecked,
        style: MSHCheckboxStyle.stroke,
        onChanged: checkBoxCallback,
      ),
    );
  }
}
