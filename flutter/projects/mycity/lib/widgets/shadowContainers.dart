import 'package:mycity/constants.dart';
import "package:flutter/material.dart";

class ShadowContainers extends StatelessWidget {
  const ShadowContainers({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      width: MediaQuery.of(context).size.width - 260,
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
    );
  }
}
