import "package:flutter/material.dart";

class ProgressDialog extends StatelessWidget {
  String message;
  ProgressDialog({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.black,
      child: Container(
        margin: EdgeInsets.all(2.0),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Color(0xFFFFE438),
          borderRadius: BorderRadius.circular(2.0),
        ),
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child: Row(
            children: [
              SizedBox(
                width: 6.0,
              ),
              CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
              ),
              SizedBox(
                width: 26.0,
              ),
              Text(
                message,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 12.0,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
