import 'package:flutter/material.dart';
import '../providers/products.dart';
import 'package:provider/provider.dart';
import 'dart:ui';

import '../widgets/product_item.dart';

class ProductsGrid extends StatelessWidget {
  var pixelRatio = window.devicePixelRatio;

  @override
  Widget build(BuildContext context) {
    final ProductsData = Provider.of<Products>(context);
    final products = ProductsData.items;
    var logicalScreenSize = window.physicalSize / pixelRatio;
    var logicalWidth = logicalScreenSize.width;

    return GridView.builder(
      padding: const EdgeInsets.all(10.0),
      itemCount: products.length,
      itemBuilder: (ctx, i) => ProductItem(
        products[i].id,
        products[i].title,
        products[i].imageUrl,
      ),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 5,
        mainAxisSpacing: 10,
        mainAxisExtent: logicalWidth - 200,
      ),
    );
  }
}
