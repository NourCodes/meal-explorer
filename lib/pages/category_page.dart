import 'package:flutter/material.dart';
import 'package:meal_app/data/db.dart';
import 'package:meal_app/pages/meal_page.dart';
import 'package:meal_app/widgets/category_grid.dart';
import '../models/category_model.dart';
import '../models/meal_model.dart';

class CategoryPage extends StatelessWidget {
  final List<Meal> availableMeals;

  const CategoryPage({
    super.key,
    required this.availableMeals,
  });

  void _selectCategory(BuildContext context, Category category) {
    final filteredList = availableMeals
        .where((meal) => meal.categories.contains(category.id))
        .toList();

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => MealPage(
          meals: filteredList,
          title: category.title,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: categoriesList.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.3,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
      ),
      itemBuilder: (context, index) => CategoryGrid(
        onSelectCategory: () => _selectCategory(context, categoriesList[index]),
        category: categoriesList[index],
      ),
    );
  }
}
