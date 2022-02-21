// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            'Lottie Example',
          ),
        ),
        body: Center(
          child: Lottie.network(
              'https://assets5.lottiefiles.com/packages/lf20_xiussssy.json'),
        ),
      ),
    );
  }
}
