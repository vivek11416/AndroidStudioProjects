import 'package:flutter/material.dart';

class MainElevatedButtonStyle extends StatelessWidget {
  MainElevatedButtonStyle({
    super.key,
    required this.horizontalPadding,
    required this.verticalPadding,
    required this.buttonText,
    this.onClick,
  });

  final double horizontalPadding;
  final double verticalPadding;
  final String buttonText;
  dynamic Function()? onClick;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onClick,
      style: ElevatedButton.styleFrom(
        side: BorderSide(
          width: 2, // the thickness
          color: Theme.of(context).primaryColorDark, // the color of the border
        ),
        backgroundColor: Theme.of(context).primaryColorLight,
        padding: EdgeInsets.symmetric(
          horizontal: horizontalPadding,
          vertical: verticalPadding,
        ),
      ),
      child: Text(
        buttonText,
        style: TextStyle(
          color: Colors.white,
          fontFamily: "FjallaOne",
          fontSize: 20,
        ),
      ),
    );
  }
}
