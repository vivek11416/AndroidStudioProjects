import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:uber_clone/DataHandler/appData.dart';
import 'AllScreens/loginScreen.dart';
import 'AllScreens/mainScreen.dart';
import 'AllScreens/registrationScreen.dart';
import "package:provider/provider.dart";
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  runApp(const MyApp());
}

DatabaseReference usersRef = FirebaseDatabase.instance.ref().child("users");

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppData(),
      child: MaterialApp(
        title: 'Taxi Service App',
        theme: ThemeData(
          //fontFamily: "Brand Bold",
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        //home: MainScreen(),
        //home: LoginScreen(),
        initialRoute: MainScreen.idScreen,

        routes: {
          RegistrationScreen.idScreen: (context) => RegistrationScreen(),
          MainScreen.idScreen: (context) => MainScreen(),
          LoginScreen.idScreen: (context) => LoginScreen(),
        },
      ),
    );
  }
}
