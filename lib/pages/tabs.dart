import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meal_app/pages/category_page.dart';
import 'package:meal_app/pages/filter_page.dart';
import 'package:meal_app/pages/meal_page.dart';
import 'package:meal_app/providers/favorite_provider.dart';
import 'package:meal_app/widgets/drawer.dart';
import '../providers/filters_provider.dart';

//initially set all filters to false
const Map<Filters, bool> kinitialFilters = {
  Filters.glutenFree: false,
  Filters.vegetarian: false,
  Filters.vegan: false,
  Filters.lactoseFree: false,
};

class TabPage extends ConsumerStatefulWidget {
  const TabPage({Key? key}) : super(key: key);

  @override
  ConsumerState<TabPage> createState() => _TabPageState();
}

class _TabPageState extends ConsumerState<TabPage> {
  //we will always start with category page
  int _selectPageIndex = 0;
//for the navigation bar
  void selectPage(int index) {
    setState(() {
      _selectPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final filteredMeals = ref.watch(filteredMealsProvider);
    Widget activePage = CategoryPage(
      //the available meals will be only the filtered meals
      availableMeals: filteredMeals,
    );
    var activePageTitle = 'Categories';
    if (_selectPageIndex == 1) {
      final favoriteMeals = ref.watch(favoriteMealsProvider);
      activePage = MealPage(
        meals: favoriteMeals,
      );
      activePageTitle = "Favorite Meals";
    }
    void setPage(String identifier) async {
      Navigator.of(context).pop();
      if (identifier == "filter") {
        // data with the type <Map<Filters, bool>> will be returned and saved in result
        await Navigator.of(context).push<Map<Filters, bool>>(
          MaterialPageRoute(
            builder: (context) => const FilterPage(),
          ),
        );
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
