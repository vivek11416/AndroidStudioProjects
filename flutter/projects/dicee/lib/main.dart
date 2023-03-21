import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  return runApp(
    MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.red,
        appBar: AppBar(
          title: Text('Dicee'),
          backgroundColor: Colors.red,
        ),
        body: DicePage(),
      ),
    ),
  );
}

class DicePage extends StatefulWidget {
  @override
  State<DicePage> createState() => _DicePageState();
}

class _DicePageState extends State<DicePage> {
  int lDiceNum = Random().nextInt(6) + 1;
  int RDiceNum = Random().nextInt(6) + 1;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Row(
          children: <Widget>[
            Expanded(
              child: TextButton(
                onPressed: () {
                  setState(() {
                    lDiceNum = Random().nextInt(6) + 1;
                  });
                },
                child: Image.asset(
                  'images/dice$lDiceNum.png',
                ),
              ),
            ),
            Expanded(
              child: TextButton(
                onPressed: () {
                  setState(() {
                    RDiceNum = Random().nextInt(6) + 1;
                  });
                },
                child: Image.asset(
                  'images/dice$RDiceNum.png',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
