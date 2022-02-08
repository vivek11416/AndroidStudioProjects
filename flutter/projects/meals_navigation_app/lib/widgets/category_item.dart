import 'package:flutter/material.dart';

import '../screens/cetegory_meals_screen.dart';

class CategoryItem extends StatelessWidget {
  final String id;
  final String title;
  final Image image;

  CategoryItem(this.id, this.title, this.image);

  void selectCategory(BuildContext ctx) {
    Navigator.of(ctx).pushNamed(
      CategryMealsScreen.routeName,
      arguments: {'id': id, 'title': title},
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => selectCategory(context),
      //splashColor: Theme.of(context).primaryColor,
      //borderRadius: BorderRadius.circular(15),
      child: Container(
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
            Expanded(
              flex: 2,
              child: Text(
                title,
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
