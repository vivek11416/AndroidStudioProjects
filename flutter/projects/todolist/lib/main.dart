import 'package:flutter/material.dart';
import 'screens/task_screen.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart';
import 'package:todolist/models/tasks_data.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TaskData(),
      child: MaterialApp(
        home: TaskScreen(),
      ),
    );
  }
}
