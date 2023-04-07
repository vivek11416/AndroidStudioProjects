import 'package:flutter/material.dart';
import 'package:todolist/widgets/task_tile.dart';

class TaskLists extends StatelessWidget {
  const TaskLists({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        SizedBox(
          height: 40,
        ),
        TaskTile(),
        TaskTile(),
      ],
    );
  }
}
