import 'package:flutter/material.dart';

class ProductDetailScreen extends StatelessWidget {
  //final String title;

  //ProductDetailScreen(this.title);
  //const ProductDetailScreen({ Key? key }) : super(key: key);
  static const routeName = '/product-detail';

  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context).settings.arguments as String;
    return Scaffold(
      appBar: AppBar(
        title: Text(productId),
      ),
    );
  }
}
