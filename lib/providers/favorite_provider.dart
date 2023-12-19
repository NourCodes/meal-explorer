import 'package:riverpod/riverpod.dart';

import '../models/meal_model.dart';

class FavoriteMealsNotifier extends StateNotifier<List<Meal>> {
  FavoriteMealsNotifier() : super([]);
  bool toggleFavoriteMealProvider(Meal meal) {
    final favoriteMeal = state.contains(meal);
    if (favoriteMeal) {
      // if meal is favorite remove the meal that has the same id else add it
      state = state.where((element) => element.id != meal.id).toList();
      return false;
    } else {
      state = [...state, meal];
      return true;
    }
  }
}

final favoriteMealsProvider =
    StateNotifierProvider<FavoriteMealsNotifier, List<Meal>>(
        (ref) => FavoriteMealsNotifier());
