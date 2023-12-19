import 'package:meal_app/providers/meal_provider.dart';
import 'package:riverpod/riverpod.dart';

enum Filters {
  glutenFree,
  vegan,
  lactoseFree,
  vegetarian,
}

class FilterNotifier extends StateNotifier<Map<Filters, bool>> {
  FilterNotifier()
      : super({
          Filters.glutenFree: false,
          Filters.vegetarian: false,
          Filters.lactoseFree: false,
          Filters.vegan: false,
        });

  void setFilters(Map<Filters, bool> selectedFilters) {
    state = selectedFilters;
  }

  void setFilter(Filters filter, bool isActive) {
    state = {
      ...state,
      filter: isActive,
    };
  }
}

final filterProvider =
    StateNotifierProvider<FilterNotifier, Map<Filters, bool>>(
        (ref) => FilterNotifier());

//A provider that returns a list of filtered meals
final filteredMealsProvider = Provider((ref) {
  final meals = ref.watch(mealProvider);
  final activeFilters = ref.watch(filterProvider);
  return meals.where((element) {
    if (activeFilters[Filters.lactoseFree]! && !element.isLactoseFree) {
      return false;
    }
    if (activeFilters[Filters.glutenFree]! && !element.isGlutenFree) {
      return false;
    }
    if (activeFilters[Filters.vegan]! && !element.isVegan) {
      return false;
    }
    if (activeFilters[Filters.vegetarian]! && !element.isVegetarian) {
      return false;
    }

    return true;
  }).toList();
});
