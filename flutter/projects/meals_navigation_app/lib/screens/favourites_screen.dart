import 'package:flutter/material.dart';
import '../models/meal.dart';
import './tabs_screen.dart';
import '../widgets/meal_item.dart';

class FavoritesScreen extends StatelessWidget {
  final List<Meal> _favMeals;

  FavoritesScreen(this._favMeals);

  @override
  Widget build(BuildContext context) {
    if (_favMeals.isEmpty) {
      return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Text('You have no favorites yet - start adding some !'),
        ),
      );
    } else {
      return ListView.builder(
        itemBuilder: (ctx, index) {
          return MealItem(
            id: _favMeals[index].id,
            title: _favMeals[index].title,
            imageUrl: _favMeals[index].imageUrl,
            duration: _favMeals[index].duration,
            complexity: _favMeals[index].complexity,
            affordability: _favMeals[index].affordability,
          );
        },
        itemCount: _favMeals.length,
      );
    }
  }
}
