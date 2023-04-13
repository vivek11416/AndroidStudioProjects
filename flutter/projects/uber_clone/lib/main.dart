import 'package:flutter/material.dart';
import 'package:uber_clone/AllScreens/loginscreen.dart';
import 'package:uber_clone/AllScreens/mainScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Taxi Service App',
      theme: ThemeData(
        fontFamily: "Brand Bold",
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      //home: MainScreen(),
      home: LoginScreen(),
    );
  }
}
