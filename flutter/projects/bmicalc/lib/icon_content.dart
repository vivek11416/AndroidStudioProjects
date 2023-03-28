import 'package:flutter/material.dart';
import 'constants.dart';

class iconContent extends StatelessWidget {
  const iconContent({
    super.key,
    required this.iconIm,
    required this.iconText,
    required this.iconTextStyle,
  });
  final IconData iconIm;
  final String iconText;
  final TextStyle iconTextStyle;

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
          style: iconTextStyle,
        )
      ],
    );
  }
}
