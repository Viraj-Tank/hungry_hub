import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hungry_hub/controller/home_controller.dart';
import 'package:hungry_hub/models/meal.dart';

import '../../models/meal_category.dart';
import 'meal_list_item.dart';

class MealList extends StatefulWidget {
  final MealCategory category;

  MealList({
    required this.category,
  });

  @override
  State<MealList> createState() => _MealListState();
}

class _MealListState extends State<MealList> with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    Get.find<HomeController>().fetchMealsListByCategory(widget.category.mealCategory);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    HomeController homeController = Get.find();
    return Obx(
      () => homeController.mealsListByCategory.containsKey(widget.category.mealCategory)
          ? _mealsListView(homeController.mealsListByCategory[widget.category.mealCategory] ?? [], homeController)
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }

  ListView _mealsListView(List<Meal> data, HomeController homeController) {
    return ListView.separated(
      itemBuilder: (context, index) {
        final meal = data[index];
        return MealListItem(meal: meal);
      },
      itemCount: data.length,
      separatorBuilder: (_, __) => const Divider(),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
