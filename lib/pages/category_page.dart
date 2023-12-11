import 'package:flutter/material.dart';
import 'package:meal_app/data/db.dart';
import 'package:meal_app/pages/meal_page.dart';
import 'package:meal_app/widgets/category_grid.dart';

class CategoryPage extends StatelessWidget {
  const CategoryPage({super.key});
  void _selectCategory(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => const MealPage(meals: meals, title: "Categories"),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Category'),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: categoriesList.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1.3,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
        itemBuilder: (context, index) => CategoryGrid(
          onSelectCategory: () => _selectCategory(context),
          category: categoriesList[index],
        ),
      ),
    );
  }
}
