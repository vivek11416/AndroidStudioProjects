import 'package:flutter/material.dart';
import '../widgets/main_drawer.dart';

class FiltersScreen extends StatefulWidget {
  static const routeName = '/filters';
  final Function saveFilters;
  final Map<String, bool> currentFilters;

  FiltersScreen(this.currentFilters, this.saveFilters);

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  var _glutenFree = false;
  var _vegan = false;
  var _vegetarian = false;
  var _lactoseFree = false;

  initState() {
    _glutenFree = widget.currentFilters['gluten'];
    _vegan = widget.currentFilters['lactose'];
    _vegetarian = widget.currentFilters['vegan'];
    _lactoseFree = widget.currentFilters['vegetarian'];

    super.initState();
  }

  Widget _buildSwitchListTile(
      String title, String subTitle, var flag, Function updateValue) {
    return SwitchListTile(
      title: Text(title),
      value: flag,
      subtitle: Text(subTitle),
      onChanged: updateValue,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Filters'),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              final selectedFilters = {
                "gluten": _glutenFree,
                "lactose": _lactoseFree,
                "vegan": _vegan,
                "vegetarian": _vegetarian,
              };
              widget.saveFilters(selectedFilters);
            },
            icon: Icon(Icons.save),
          )
        ],
      ),
      drawer: MainDrawer(),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(20),
            child: Text(
              'Adjust Your Meal Selection !',
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          Expanded(
            child: ListView(
              children: <Widget>[
                _buildSwitchListTile(
                  'Gluten-Free',
                  'Only Gluten free meals.',
                  _glutenFree,
                  (newValue) => setState(
                    () {
                      _glutenFree = newValue;
                    },
                  ),
                ),
                _buildSwitchListTile(
                  'Vegan',
                  'Only Vegan meals.',
                  _vegan,
                  (newValue) => setState(
                    () {
                      _vegan = newValue;
                    },
                  ),
                ),
                _buildSwitchListTile(
                  'Vegetarian',
                  'Only Vegetarian meals.',
                  _vegetarian,
                  (newValue) => setState(
                    () {
                      _vegetarian = newValue;
                    },
                  ),
                ),
                _buildSwitchListTile(
                  'Lactose-Free',
                  'Only Lactose free meals.',
                  _lactoseFree,
                  (newValue) => setState(
                    () {
                      _lactoseFree = newValue;
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
