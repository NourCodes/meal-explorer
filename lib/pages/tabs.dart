import 'package:flutter/material.dart';
import 'package:meal_app/data/db.dart';
import 'package:meal_app/pages/category_page.dart';
import 'package:meal_app/pages/filter_page.dart';
import 'package:meal_app/pages/meal_page.dart';
import 'package:meal_app/widgets/drawer.dart';

import '../models/meal_model.dart';

//initially set all filters to false
const Map<Filters, bool> kinitialFilters = {
  Filters.glutenFree: false,
  Filters.vegetarian: false,
  Filters.vegan: false,
  Filters.lactoseFree: false,
};

class TabPage extends StatefulWidget {
  const TabPage({Key? key}) : super(key: key);

  @override
  State<TabPage> createState() => _TabPageState();
}

class _TabPageState extends State<TabPage> {
  // list to store favorite meals
  final List<Meal> favoriteList = [];
  //we will always start with category page
  int _selectPageIndex = 0;
  //initially all the filters will be set to 0
  Map<Filters, bool> _selectedFilters = kinitialFilters;

  void toggleFavoriteMeal(Meal meal) {
    //check if the meal is already there
    final isExisting = favoriteList.contains(meal);
    //if meal is already in favorite list and button is pressed remove the meal and display a message
    if (isExisting == true) {
      setState(() {
        favoriteList.remove(meal);
      });
      showMessage("Meal was removed");
    } else {
      //if meal is not in the favorite list and button is pressed add the meal and display a message

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

//for the navigation bar
  void selectPage(int index) {
    setState(() {
      _selectPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final filteredMeals = meals.where((element) {
      //if the the selected filter is true and the meal is not lactose free return false
      if (_selectedFilters[Filters.lactoseFree]! && !element.isLactoseFree) {
        return false;
      }
      if (_selectedFilters[Filters.glutenFree]! && !element.isGlutenFree) {
        return false;
      }
      if (_selectedFilters[Filters.vegan]! && !element.isVegan) {
        return false;
      }
      if (_selectedFilters[Filters.vegetarian]! && !element.isVegetarian) {
        return false;
      }

      return true;
    }).toList();

    Widget activePage = CategoryPage(
      //the available meals will be only the filtered meals
      availableMeals: filteredMeals,
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
        // data with the type <Map<Filters, bool>> will be returned and saved in result
        final result = await Navigator.of(context).push<Map<Filters, bool>>(
          MaterialPageRoute(
            builder: (context) => FilterPage(selectedFilters: _selectedFilters),
          ),
        );
        //update the value
        setState(() {
          //if there is no selected filters set it to kinitialFilters
          _selectedFilters = result ?? kinitialFilters;
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
