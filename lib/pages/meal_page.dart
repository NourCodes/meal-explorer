import 'package:flutter/material.dart';
import 'package:meal_app/widgets/meal_item.dart';
import '../models/meal_model.dart';
import 'meal_detail_page.dart';

class MealPage extends StatelessWidget {
  final List<Meal> meals;
  final String? title;
  final void Function(Meal meal) onToggleFavoriteMeal;

  const MealPage({
    Key? key,
    required this.meals,
    this.title,
    required this.onToggleFavoriteMeal,
  }) : super(key: key);

  void selectMeal(BuildContext context, Meal meal) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => MealDetailPage(
        onToggleFavoriteMeal: onToggleFavoriteMeal,
        meal: meal,
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    Widget body = Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "No Data",
            style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            "Try to select a different category!",
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
          ),
        ],
      ),
    );
    if (meals.isNotEmpty) {
      body = ListView.builder(
        itemCount: meals.length,
        itemBuilder: (context, index) => MealItem(
          meal: meals[index],
          onSelectMeal: (meal) {
            selectMeal(context, meals[index]);
          },
        ),
      );
    }
    if (title == null) {
      return body;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(title!),
      ),
      body: body,
    );
  }
}
