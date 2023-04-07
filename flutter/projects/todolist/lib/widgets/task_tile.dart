import 'package:flutter/material.dart';
import 'package:msh_checkbox/msh_checkbox.dart';

class TaskTile extends StatelessWidget {
  const TaskTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text(
        'Item1',
        style: TextStyle(fontSize: 25),
      ),
      trailing: MSHCheckbox(
        size: 25,
        value: false,
        style: MSHCheckboxStyle.stroke,
        onChanged: (bool? value) {
          final item1 = value!;
        },
      ),
    );
  }
}
