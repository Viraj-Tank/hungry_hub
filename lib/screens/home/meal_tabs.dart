import 'package:flutter/material.dart';

import '../../models/meal_category.dart';
import 'meals_list.dart';

class MealTabs extends StatelessWidget {
  final List<MealCategory> categories;

  MealTabs({
    super.key,
    required this.categories,
  });

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: categories.length,
      child: Column(
        children: [
          TabBar(
            isScrollable: true,
            tabs: categories.map((category) => Tab(text: category.mealCategory)).toList(),
          ),
          Expanded(
            child: TabBarView(
              children: categories.map((category) => MealList(category: category)).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
