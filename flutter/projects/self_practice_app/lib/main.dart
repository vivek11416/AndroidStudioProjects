// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'dart:math';

void main() => runApp(myPractApp());

class myPractApp extends StatefulWidget {
  @override
  _myPractAppState createState() => _myPractAppState();
}

class _myPractAppState extends State<myPractApp> {
  String currColor = 'Red';
  var textToDisplay = 'Red';
  var rng = Random();

  var colList = ['Red', 'Green', 'Black', 'Blue'];
  void updateQues(String butCol) {
    setState(() {
      if (butCol == currColor) {
        currColor = colList[rng.nextInt(4)];
        textToDisplay = currColor;
      } else {
        //print(numWrongSel);
        textToDisplay = "Wrong slection ! please select : " + currColor;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    //print(rng.nextInt(4));

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.orange[200],
          centerTitle: true,
          // ignore: prefer_const_constructors
          title: Text(
            'Click The Color !',
            style: TextStyle(color: Colors.black),
          ),
          leading: IconButton(
            icon: Icon(
              Icons.accessibility_new_rounded,
              color: Colors.black,
            ),
            onPressed: null,
          ),
        ),
        body: Stack(
          alignment: AlignmentDirectional.center,
          children: <Widget>[
            Positioned(
              top: 10,
              left: 12,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Colors.red[900],
                    //padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                    textStyle: TextStyle(fontSize: 15)),
                onPressed: () => updateQues('Red'),
                child: Text('Red'),
              ),
            ),
            Positioned(
              top: 10,
              left: 330,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Colors.green,
                    //padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                    textStyle: TextStyle(fontSize: 15)),
                onPressed: () => updateQues('Green'),
                child: Text('Green'),
              ),
            ),
            Positioned(
              top: 550,
              left: 12,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Colors.black,
                    //padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                    textStyle: TextStyle(fontSize: 15)),
                onPressed: () => updateQues('Black'),
                child: Text('Black'),
              ),
            ),
            Positioned(
              top: 550,
              left: 330,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Colors.blue,
                    //padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                    textStyle: TextStyle(fontSize: 15)),
                onPressed: () => updateQues('Blue'),
                child: Text('Blue'),
              ),
            ),
            Positioned(
              top: 250,
              left: 125,
              child: Text(
                textToDisplay,
                style: TextStyle(fontSize: 15),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
