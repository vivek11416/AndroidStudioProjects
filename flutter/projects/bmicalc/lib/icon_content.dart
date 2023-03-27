import 'package:flutter/material.dart';

class iconContent extends StatelessWidget {
  const iconContent({super.key, required this.iconIm, required this.iconText});
  final IconData iconIm;
  final String iconText;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          iconIm,
          size: 64.0,
        ),
        SizedBox(
          height: 15.0,
        ),
        Text(
          iconText,
          style: TextStyle(
            fontSize: 18.0,
            color: Color(0xFF8D8E98),
          ),
        )
      ],
    );
  }
}
