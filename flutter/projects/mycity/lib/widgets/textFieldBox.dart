import "package:flutter/material.dart";

class TextFieldBox extends StatelessWidget {
  TextFieldBox(
      {super.key,
      required this.hintText,
      required this.isDefaultHeight,
      this.textBoxHeight,
      required this.controller,
      this.keyboardType,
      required this.obscureText});
  final String hintText;
  final bool isDefaultHeight;
  double? textBoxHeight = 50;
  TextEditingController controller;
  TextInputType? keyboardType;
  bool obscureText = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 15),
      child: isDefaultHeight
          ? TextField(
              obscureText: obscureText,
              controller: controller,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Theme.of(context).primaryColorDark,
                  ),
                ),
                hintText: hintText,
                hintStyle: TextStyle(
                  fontSize: 13,
                  fontFamily: "BarlowCondensed",
                ),
              ),
            )
          : SizedBox(
              height: textBoxHeight,
              child: TextField(
                obscureText: obscureText,
                controller: controller,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Theme.of(context).primaryColorDark,
                    ),
                  ),
                  hintText: hintText,
                  hintStyle: TextStyle(
                    fontSize: 13,
                    fontFamily: "BarlowCondensed",
                  ),
                ),
              ),
            ),
    );
  }
}
