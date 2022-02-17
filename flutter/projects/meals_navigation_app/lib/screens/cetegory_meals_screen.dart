import 'package:flutter/material.dart';
import '../widgets/meal_item.dart';

import '../dummy_data.dart';
import '../models/meal.dart';

class CategryMealsScreen extends StatefulWidget {
  static String routeName = '/categories-screen';

  final List<Meal> availableMeals;

  CategryMealsScreen(this.availableMeals);

  @override
  State<CategryMealsScreen> createState() => _CategryMealsScreenState();
}

class _CategryMealsScreenState extends State<CategryMealsScreen> {
  String categoryTitle;
  var _loadedInitData = false;
  List<Meal> diplayedMeals;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (!_loadedInitData) {
      final routeArgs =
          ModalRoute.of(context).settings.arguments as Map<String, String>;
      categoryTitle = routeArgs['title'];
      final categoryId = routeArgs['id'];
      diplayedMeals = widget.availableMeals.where((meal) {
        return meal.categories.contains(categoryId);
      }).toList();
      _loadedInitData = true;
    }

    super.didChangeDependencies();
  }

  void _removeMeal(String mealId) {
    setState(() {
      diplayedMeals.removeWhere((meal) => meal.id == mealId);
    });
  }

  // final String categoryId;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle),
      ),
      body: ListView.builder(
        itemBuilder: (ctx, index) {
          return MealItem(
            id: diplayedMeals[index].id,
            title: diplayedMeals[index].title,
            imageUrl: diplayedMeals[index].imageUrl,
            duration: diplayedMeals[index].duration,
            complexity: diplayedMeals[index].complexity,
            affordability: diplayedMeals[index].affordability,
          );
        },
        itemCount: diplayedMeals.length,
      ),
    );
  }
}
