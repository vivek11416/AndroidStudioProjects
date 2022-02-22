import 'package:flutter/material.dart';
import '../widgets/products_grid.dart';

import 'dart:ui';

class ProductsOverviewScreen extends StatelessWidget {
  //const ProductsOverviewScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var pixelRatio = window.devicePixelRatio;
    //Size in logical pixels
    var logicalScreenSize = window.physicalSize / pixelRatio;
    var logicalWidth = logicalScreenSize.width;
    var logicalHeight = logicalScreenSize.height;
    return Scaffold(
      appBar: AppBar(
        title: Text('MyShop'),
      ),
      body: ProductsGrid(),
    );
  }
}
