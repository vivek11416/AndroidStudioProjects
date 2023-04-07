import 'package:flutter/material.dart';
import 'package:wearable_communicator/wearable_communicator.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  TextEditingController? _controller;
  String value = '';

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();

    WearableListener.listenForMessage((msg) {
      print(msg);
    });
    WearableListener.listenForDataLayer((msg) {
      print(msg);
    });
  }

  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextField(
                controller: _controller,
                decoration: InputDecoration(
                    border: InputBorder.none, labelText: 'Enter some text'),
                onChanged: (String val) async {
                  setState(() {
                    value = val;
                  });
                },
              ),
              ElevatedButton(
                child: Text('Send message to wearable'),
                onPressed: () {
                  primaryFocus!.unfocus(disposition: UnfocusDisposition.scope);
                  WearableCommunicator.sendMessage({"text": value});
                },
              ),
              ElevatedButton(
                child: Text('set data on wearable'),
                onPressed: () {
                  WearableListener.listenForMessage((msg) {
                    print(msg);
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
