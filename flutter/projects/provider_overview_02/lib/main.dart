import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/dog.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Provider<Dog>(
      create: (context) => Dog(
        name: 'Sun',
        breed: 'Bulldog',
        age: 3,
      ),
      child: MaterialApp(
        title: 'Provider 02',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Provider 02'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '- name: :${Provider.of<Dog>(context).name}',
              style: TextStyle(fontSize: 20.0),
            ),
            SizedBox(
              height: 10,
            ),
            BreedAndAge(),
          ],
        ),
      ),
    );
  }
}

class BreedAndAge extends StatelessWidget {
  const BreedAndAge({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          '- breed:${Provider.of<Dog>(context).breed}',
          style: TextStyle(fontSize: 20.0),
        ),
        SizedBox(
          height: 10.0,
        ),
        Age(),
      ],
    );
  }
}

class Age extends StatelessWidget {
  const Age({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          '- age: ${Provider.of<Dog>(context).age}',
          style: TextStyle(fontSize: 20.0),
        ),
        SizedBox(
          height: 20,
        ),
        ElevatedButton(
          onPressed: () => Provider.of<Dog>(context, listen: false).grow(),
          child: Text(
            'Grow',
            style: TextStyle(fontSize: 20.0),
          ),
        ),
      ],
    );
  }
}
