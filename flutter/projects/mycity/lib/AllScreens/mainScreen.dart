import 'package:flutter/material.dart';
import 'package:mycity/constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});
  static const String idScreen = "mainScreen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //backgroundColor: Theme.of(context).secondaryHeaderColor,
        backgroundColor: Color(0xfff5f7fb),
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 15, right: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(
                      FontAwesomeIcons.arrowLeft,
                      color: Theme.of(context).primaryColorDark,
                      size: 35,
                    ),
                    Icon(
                      FontAwesomeIcons.bars,
                      color: Theme.of(context).primaryColorDark,
                      size: 35,
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              SizedBox(
                height: 180,
                width: MediaQuery.of(context).size.width - 30,
                child: Container(
                  child: Text('Hello'),
                  //padding: EdgeInsets.all(50),
                  decoration: BoxDecoration(
                    //border: Border.all(color: Theme.of(context).primaryColorDark),
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: boxShadows,
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
