import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:ui' as ui;

void main() {
  runApp(const MyWidget());
}

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Icon> answerList = [];
  int Total_Score = 0;
  @override
  Widget build(BuildContext context) {
    //print(MediaQueryData.fromWindow(ui.window).size.height / 3);
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: (answerList.length < 11)
              ? Column(
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    if (answerList.length < 11)
                      SizedBox(
                        height:
                            MediaQueryData.fromWindow(ui.window).size.height /
                                1.35,
                        child: Center(
                          child: Text(
                            'the score  is $Total_Score',
                            style: TextStyle(color: Colors.black),
                          ), //Text
                        ),
                      ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 8),
                      width: double.infinity - 5,
                      height: 50,
                      child: TextButton(
                        onPressed: () {
                          setState(
                            () {
                              Total_Score++;
                              answerList.add(
                                Icon(
                                  Icons.check,
                                  color: Colors.green,
                                ),
                              );
                            },
                          );
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 4.0, horizontal: 26.0),
                          child: Text(
                            'True',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.green),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 8),
                      width: double.infinity - 5,
                      height: 50,
                      child: TextButton(
                        onPressed: () {
                          setState(
                            () {
                              Total_Score--;
                              answerList.add(
                                Icon(
                                  Icons.close,
                                  color: Colors.red,
                                ),
                              );
                            },
                          );
                        },
                        child: Text(
                          'False',
                          style: TextStyle(color: Colors.white),
                        ),
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.red),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: new EdgeInsets.all(12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: answerList,
                      ),
                    )
                  ],
                )
              : Column(children: [
                  Text(
                    'Quiz is complete !',
                  ),
                  TextButton(
                    onPressed: () {
                      setState(
                        () {
                          Total_Score = 0;
                          answerList.clear();
                        },
                      );
                    },
                    child: Text(
                      'Restart',
                    ),
                  )
                ]),
        ),
      ),
    );
  }
}
