import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

void main() {
  runApp(XylophoneApp());
}

class XylophoneApp extends StatelessWidget {
  Expanded buildKey({Color color, int SoundNumber}) {
    return Expanded(
      child: TextButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(color),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0.0),
            ),
          ),
        ),
        onPressed: () {
          final player = AudioCache();
          player.play('note$SoundNumber.wav');
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Xylophone',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
            ),
          ),
          backgroundColor: Colors.orange,
        ),
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              buildKey(color: Colors.red, SoundNumber: 1),
              buildKey(color: Colors.green, SoundNumber: 2),
              buildKey(color: Colors.blue, SoundNumber: 3),
              buildKey(color: Colors.brown, SoundNumber: 4),
              buildKey(color: Colors.teal, SoundNumber: 5),
              buildKey(color: Colors.purple, SoundNumber: 6),
              buildKey(color: Colors.pink, SoundNumber: 7),
            ],
          ),
        ),
      ),
    );
  }
}
