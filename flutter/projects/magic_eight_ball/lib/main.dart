import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  return runApp(
    MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.teal.shade400,
        body: eightBall(),
        appBar: AppBar(
          title: Text('Eight Ball'),
          backgroundColor: Colors.teal,
        ),
      ),
    ),
  );
}

class eightBall extends StatefulWidget {
  const eightBall({super.key});

  @override
  State<eightBall> createState() => _eightBallState();
}

class _eightBallState extends State<eightBall> {
  int picNum = Random().nextInt(5) + 1;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(28.0),
      child: SafeArea(
        child: Center(
          child: TextButton(
            onPressed: () {
              setState(() {
                picNum = Random().nextInt(5) + 1;
              });
            },
            child: Image.asset('images/ball$picNum.png'),
          ),
        ),
      ),
    );
  }
}
