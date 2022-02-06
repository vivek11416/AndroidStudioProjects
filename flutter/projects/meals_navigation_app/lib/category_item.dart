import 'dart:ffi';

import 'package:flutter/material.dart';

import './dummy_data.dart';

class CategoryItem extends StatelessWidget {
  final String title;
  final Image image;

  CategoryItem(this.title, this.image);
  @override
  Widget build(BuildContext context) {
    return Container(
      //padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          Expanded(
            flex: 6,
            child: ClipRRect(
              child: image,
            ),
          ),
          Expanded(flex: 2, child: Text(title)),
        ],
      ),
    );
  }
}
