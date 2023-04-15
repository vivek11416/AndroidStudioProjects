import 'package:flutter/material.dart';

class dividerWidget extends StatelessWidget {
  const dividerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Divider(
      height: 1.0,
      color: Colors.grey[300],
      thickness: 1.0,
    );
  }
}
