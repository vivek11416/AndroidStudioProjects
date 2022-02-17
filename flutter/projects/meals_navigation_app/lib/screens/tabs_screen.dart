import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/widgets/main_drawer.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import './categories_screen.dart';
import './favourites_screen.dart';
import '../models/meal.dart';

class TabsScreen extends StatefulWidget {
  final List<Meal> favMeal;

  TabsScreen(this.favMeal);

  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  List<Map<String, Object>> _pages;
  int _selectedPageIndex = 0;
  void initState() {
    _pages = [
      {
        'page': CategoriesScreen(),
        'title': 'Categories',
      },
      {
        'page': FavoritesScreen(widget.favMeal),
        'title': 'Your Favorites',
      },
    ];
    super.initState();
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MainDrawer(),
      appBar: AppBar(
        title: Text(
          _pages[_selectedPageIndex]['title'] as String,
        ),
      ),
      body: _pages[_selectedPageIndex]['page'],
      bottomNavigationBar: CurvedNavigationBar(
        height: 50,
        backgroundColor: Colors.white,
        buttonBackgroundColor: Theme.of(context).primaryColor,
        animationCurve: Curves.ease,
        items: <Widget>[
          Icon(
            Icons.category,
            size: 25,
            color: Colors.lime,
          ),
          Icon(
            Icons.star,
            size: 25,
            color: Colors.lime,
          ),
        ],
        onTap: (index) {
          //Handle button tap
          _selectPage(index);
        },
      ),
      //body: Container(color: Colors.blueAccent),
    );
  }
}
