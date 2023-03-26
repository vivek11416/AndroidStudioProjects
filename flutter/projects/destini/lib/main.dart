import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'package:auto_size_text/auto_size_text.dart';
import 'story_brain.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Container(
        decoration: new BoxDecoration(
          color: Colors.green,
          image: new DecorationImage(
            image: new AssetImage("images/background.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: MyHomePage(title: 'Destini'),
      ),
    );
  }
}

StoryBrain StoryBrainObj = StoryBrain();

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            SizedBox(
              height: MediaQueryData.fromWindow(ui.window).size.height / 1.8,
              child: Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  child: AutoSizeText(
                    StoryBrainObj.getStory(),
                    style: TextStyle(
                      fontSize: 22,
                      color: Colors.white,
                    ),
                    maxLines: 10,
                  ),
                ), //Text
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 8),
              width: double.infinity - 5,
              height: 100,
              child: TextButton(
                onPressed: () {
                  setState(
                    () {
                      StoryBrainObj.nextStory(1);
                    },
                  );
                },
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 4.0, horizontal: 10.0),
                  child: AutoSizeText(
                    StoryBrainObj.getChoice1(),
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                    ),
                    maxLines: 4,
                  ),
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                    Theme.of(context).colorScheme.primary,
                  ),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
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
              height: 100,
              child: Visibility(
                visible: true,
                child: TextButton(
                  onPressed: () {
                    setState(
                      () {
                        StoryBrainObj.nextStory(2);
                      },
                    );
                  },
                  child: AutoSizeText(
                    StoryBrainObj.getChoice2(),
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                    ),
                    maxLines: 4,
                  ),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                      Theme.of(context).colorScheme.primary,
                    ),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
