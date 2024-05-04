import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hungry_hub/controller/home_controller.dart';

import '../../models/meal.dart';
import '../../utils/constant/string_constants.dart';
import '../../widgets/sized_boxes.dart';

class MealListItem extends StatelessWidget {
  const MealListItem({
    super.key,
    required this.meal,
  });

  final Meal meal;

  @override
  Widget build(BuildContext context) {
    HomeController homeController = Get.find();
    return ListTile(
      title: Text(
        meal.mealName,
        style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
      ),
      trailing: ClipRRect(
        borderRadius: BorderRadius.circular(12.0),
        child: SizedBox(
          width: 60,
          height: 60,
          child: CachedNetworkImage(imageUrl: meal.mealThumbnail),
        ),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          gapH4,
          Row(
            children: [
              Expanded(
                child: Text(
                  'INR ${meal.mealPrice}',
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
              ),
              const Expanded(
                child: Text(
                  '15 Calories',
                  textAlign: TextAlign.right,
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
          gapH8,
          const Text(
            StringConstants.dummyDescription,
            style: TextStyle(fontWeight: FontWeight.w300, color: Colors.grey),
          ),
          gapH8,
          meal.mealCount == 0
              ? GestureDetector(
                  onTap: () => homeController.addToCart(meal),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.green.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(24.0),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 32.0),
                    child: const Text(
                      StringConstants.addToCart,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                )
              : Container(
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(24.0),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () => homeController.decreaseMealCount(meal),
                        icon: const Icon(Icons.remove, color: Colors.white),
                        iconSize: 18,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          '${meal.mealCount}',
                          style: const TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                      IconButton(
                        onPressed: () => homeController.increaseMealCount(meal),
                        icon: const Icon(Icons.add, color: Colors.white),
                      ),
                    ],
                  ),
                ),
        ],
      ),
    );
  }
}
