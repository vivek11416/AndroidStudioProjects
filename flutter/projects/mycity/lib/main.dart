import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mycity/AllScreens/initialStartupScreen.dart';
import 'package:mycity/AllScreens/mainScreen.dart';
import 'package:mycity/AllScreens/registrationScreen.dart';
import 'AllScreens/loginScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
      overlays: [SystemUiOverlay.top]);
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.black.withOpacity(0.002),
  ));

  runApp(const MyApp());
}

DatabaseReference usersRef = FirebaseDatabase.instance.ref().child("users");

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My City',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColorDark: Color(0xff645CBB),
        primaryColor: Color(0xffA084DC),
        primaryColorLight: Color(0xffBFACE2),
        secondaryHeaderColor: Color(0xffEBC7E6),
        unselectedWidgetColor: Color(0xffA084DC),
        inputDecorationTheme: InputDecorationTheme(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Color(0xffA084DC),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Color(0xff645CBB),
            ),
          ),
        ),
      ),
      //home: IntialStartupScreen(),
      home: MainScreen(),
      //LoginScreen.idScreen,
      //initialRoute: IntialStartupScreen.idScreen,
      routes: {
        RegistrationScreen.idScreen: (context) => RegistrationScreen(),
        LoginScreen.idScreen: (context) => LoginScreen(),
        MainScreen.idScreen: (context) => MainScreen(),
      },
    );
  }
}
