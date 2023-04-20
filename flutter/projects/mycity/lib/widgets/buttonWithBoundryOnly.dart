import 'package:flutter/material.dart';

class ButtonWithBoundryOnly extends StatelessWidget {
  const ButtonWithBoundryOnly({super.key, required this.buttonText});

  final String buttonText;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        side: BorderSide(
          width: 1, // the thickness
          color: Theme.of(context).primaryColorDark, // the color of the border
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      child: Text(
        buttonText,
        style: TextStyle(
          color: Colors.black,
          fontFamily: "FjallaOne",
        ),
      ),
    );
  }
}
