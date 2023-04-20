import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:mycity/AllScreens/loginScreen.dart';
import 'package:mycity/widgets/mainEleveatedButtonStyle.dart';

class IntialStartupScreen extends StatelessWidget {
  const IntialStartupScreen({super.key});
  static const String idScreen = "initialStartup";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Image.asset(
            'assets/images/initialCity.gif',
            width: MediaQuery.of(context).size.width * 3,
            height: 400,
            fit: BoxFit.cover,
          ),
          Text(
            "My City",
            style: TextStyle(
                shadows: <Shadow>[
                  Shadow(
                    offset: Offset(3.0, 3.0),
                    blurRadius: 8.0,
                    color: Colors.black26,
                  ),
                ],
                fontFamily: "Righteous",
                fontSize: 68,
                color: Theme.of(context).primaryColorDark),
          ),
          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(color: Colors.white),
                  height: 35.0,
                  width: 225.0,
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        const SizedBox(width: 15.0, height: 100.0),
                        DefaultTextStyle(
                          style: TextStyle(
                            fontSize: 20.0,
                            fontFamily: "FjallaOne",
                            color: Theme.of(context).primaryColor,
                          ),
                          child: AnimatedTextKit(
                              repeatForever: true,
                              isRepeatingAnimation: true,
                              animatedTexts: [
                                RotateAnimatedText('For The'),
                                RotateAnimatedText('By The'),
                              ]),
                        ),
                        const SizedBox(width: 10.0, height: 100.0),
                        Text(
                          'People',
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 20,
                            fontFamily: "FjallaOne",
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 80,
                ),
                Container(
                  width: 300,
                  child: Text(
                    "Connect with people within your city, Help to build a stronger community",
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: "Barlow Condensed",
                      color: Theme.of(context).primaryColorDark,
                      height: 1.8,
                    ),
                  ),
                ),
                SizedBox(
                  height: 55,
                ),
                MainElevatedButtonStyle(
                    onClick: () {
                      Navigator.pushNamedAndRemoveUntil(
                          context, LoginScreen.idScreen, (route) => false);
                    },
                    horizontalPadding: 80,
                    verticalPadding: 10,
                    buttonText: 'Join The Community')
              ],
            ),
          ),
        ],
      ),
    );
  }
}
