// ignore_for_file: missing_return

import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/dummy_data.dart';

import './screens/filters_screen.dart';
import './screens/meal_detail_screen.dart';
import './screens/cetegory_meals_screen.dart';
import './screens/tabs_screen.dart';
import './dummy_data.dart';
import './models/meal.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    "gluten": false,
    "lactose": false,
    "vegan": false,
    "vegetarian": false,
  };

  List<Meal> _availableMeals = DUMMY_MEALS;
  List<Meal> _favMeals = [];

  void _setFilters(Map<String, bool> filterData) {
    setState(() {
      _filters = filterData;
      _availableMeals = DUMMY_MEALS.where((Meal) {
        if (_filters['gluten'] && Meal.isGlutenFree) {
          return false;
        }
        if (_filters['lactose'] && !Meal.isLactoseFree) {
          return false;
        }
        if (_filters['vegan'] && !Meal.isVegan) {
          return false;
        }
        if (_filters['vegetarian'] && !Meal.isVegetarian) {
          return false;
        }
        return true;
      }).toList();
    });
  }

  void _favMealToggle(String mealId) {
    final existingIndex = _favMeals.indexWhere((meal) => meal.id == mealId);

    if (existingIndex >= 0) {
      setState(
        () {
          _favMeals.removeAt(existingIndex);
        },
      );
    } else {
      setState(
        () {
          _favMeals.add(
            DUMMY_MEALS.firstWhere((meal) => meal.id == mealId),
          );
        },
      );
    }
  }

  bool _isFavMeal(String id) {
    return _favMeals.any((meal) => meal.id == id);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DeliMeals',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        canvasColor: Color.fromRGBO(255, 254, 229, 1),
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
              bodyText1: TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              bodyText2: TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              headline6: TextStyle(
                fontSize: 16,
                fontFamily: 'RobotoCondensed',
                fontWeight: FontWeight.bold,
              ),
            ),
      ),
      //home: CategoriesScreen(),
      initialRoute: '/',
      routes: {
        '/': (ctx) => TabsScreen(_favMeals),
        CategryMealsScreen.routeName: (ctx) =>
            CategryMealsScreen(_availableMeals),
        MealDetailScreen.routeName: (ctx) =>
            MealDetailScreen(_favMealToggle, _isFavMeal),
        FiltersScreen.routeName: (ctx) => FiltersScreen(_filters, _setFilters),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('DeliMeals'),
      ),
      body: Center(
        child: Text('Navigation Time!'),
      ),
    );
  }
}
