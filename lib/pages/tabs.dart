import 'package:flutter/material.dart';
import 'package:meal_app/pages/category_page.dart';
import 'package:meal_app/pages/filter_page.dart';
import 'package:meal_app/pages/meal_page.dart';
import 'package:meal_app/widgets/drawer.dart';

import '../models/meal_model.dart';

//initially set all filters to false
Map<Filters, bool> initialFilters = {
  Filters.glutenFree: false,
  Filters.vegetarian: false,
  Filters.vegan: false,
  Filters.lactoseFree: false
};

class TabPage extends StatefulWidget {
  const TabPage({Key? key}) : super(key: key);

  @override
  State<TabPage> createState() => _TabPageState();
}

class _TabPageState extends State<TabPage> {
  final List<Meal> favoriteList = [];

  void toggleFavoriteMeal(Meal meal) {
    final isExisting = favoriteList.contains(meal);

    if (isExisting == true) {
      setState(() {
        favoriteList.remove(meal);
      });
      showMessage("Meal was removed");
    } else {
      setState(() {
        favoriteList.add(meal);
      });
      showMessage("Meal was added");
    }
  }

  void showMessage(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  int _selectPageIndex = 0;

  void selectPage(int index) {
    setState(() {
      _selectPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget activePage = CategoryPage(
      onToggleFavoriteMeal: toggleFavoriteMeal,
    );
    var activePageTitle = 'Categories';
    if (_selectPageIndex == 1) {
      activePage = MealPage(
        meals: favoriteList,
        onToggleFavoriteMeal: toggleFavoriteMeal,
      );
      activePageTitle = "Favorite Meals";
    }
    void setPage(String identifier) async {
      Navigator.of(context).pop();
      if (identifier == "filter") {
        final result = await Navigator.of(context).push<Map<Filters, bool>>(
          MaterialPageRoute(
            builder: (context) => const FilterPage(),
          ),
        );
        //update the value
        setState(() {
          initialFilters = result ?? initialFilters;
        });
      }
    }

    return Scaffold(
      drawer: MyDrawer(
        onSelectedPage: setPage,
      ),
      appBar: AppBar(
        title: Text(activePageTitle),
      ),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectPageIndex,
        onTap: (value) => selectPage(value),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.set_meal),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Favorites',
          ),
        ],
      ),
    );
  }
}
