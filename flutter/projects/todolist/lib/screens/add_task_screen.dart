import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todolist/models/tasks_data.dart';

dynamic newTaskTitle;

class AddTaskScreen extends StatelessWidget {
  const AddTaskScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 50,
          horizontal: 60,
        ),
        child: Column(
          children: [
            Text(
              'Add Task',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.lightBlueAccent,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              //autofocus: true,
              //textAlign: TextAlign.center,
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.lightBlueAccent,
                    width: 2.0,
                  ),
                ),
                border: UnderlineInputBorder(),
                labelText: 'Enter your Task',
              ),
              onChanged: (String value) {
                newTaskTitle = value;
              },
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  elevation: 6,
                  backgroundColor: Colors.lightBlueAccent,
                  minimumSize: Size(280, 50)),
              child: Text(
                'Add',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              onPressed: () {
                Provider.of<TaskData>(context, listen: false)
                    .addTask(newTaskTitle);
                Navigator.pop(context);
              },
            )
          ],
        ),
      ),
    );
  }
}
