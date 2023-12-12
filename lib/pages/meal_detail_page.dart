import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/meal_model.dart';

class MealDetailPage extends StatelessWidget {
  final Meal meal;
  const MealDetailPage({Key? key, required this.meal}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(meal.title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              meal.imageUrl,
              height: 300,
              width: double.infinity,
            ),
          ),
        ],
      ),
    );
  }
}
