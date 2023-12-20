import 'package:flutter/material.dart';
import 'package:meal_app/data/db.dart';
import 'package:meal_app/pages/meal_page.dart';
import 'package:meal_app/widgets/category_grid.dart';
import '../models/category_model.dart';
import '../models/meal_model.dart';

class CategoryPage extends StatefulWidget {
  final List<Meal> availableMeals;

  const CategoryPage({
    super.key,
    required this.availableMeals,
  });

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 1000,
      ),
    );
    _animationController.forward();

    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _selectCategory(BuildContext context, Category category) {
    final filteredList = widget.availableMeals
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
    return AnimatedBuilder(
      animation: _animationController,
      child: GridView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: categoriesList.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1.3,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
        itemBuilder: (context, index) => CategoryGrid(
          onSelectCategory: () =>
              _selectCategory(context, categoriesList[index]),
          category: categoriesList[index],
        ),
      ),
      builder: (context, child) => SlideTransition(
        position: Tween(
          begin: const Offset(
            0,
            0.5,
          ),
          end: const Offset(
            0,
            0,
          ),
        ).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Curves.easeIn,
          ),
        ),
        child: child,
      ),
    );
  }
}
