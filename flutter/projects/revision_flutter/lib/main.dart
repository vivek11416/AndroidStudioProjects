import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.blueGrey[900],
          title: Text('I am Rich'),
        ),
        backgroundColor: Colors.blueGrey[600],
        body: Center(
          child: Image(image: AssetImage('Images/diamond.png')),
        ),
      ),
    ),
  );
}
