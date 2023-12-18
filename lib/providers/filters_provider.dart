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
