import 'package:flutter/material.dart';

class containersCard extends StatelessWidget {
  containersCard(
      {super.key, required this.color, this.cardChild, this.onPress});
  final Color color;
  final Widget? cardChild;
  final void Function()? onPress;
//hhhhhh
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        child: cardChild,
        margin: EdgeInsets.all(15.0),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }
}
