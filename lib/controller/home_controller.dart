import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:hungry_hub/client/meal_client.dart';
import 'package:hungry_hub/utils/constant/string_constants.dart';

import '../models/meal.dart';
import '../models/meal_category.dart';

class HomeController extends GetxController {
  RxMap<String, List<Meal>> mealsListByCategory = <String, List<Meal>>{}.obs;
  RxList<Meal> cartItems = <Meal>[].obs;

  String get getCartItemsTotalPrice => cartItems.fold<double>(0, (previousValue, element) => previousValue + (element.mealPrice * element.mealCount)).toString();

  Future<List<MealCategory>> fetchMealCategories() async {
    try {
      final response = await MealAPiClient.getMealCategories();
      final List<dynamic> categoriesJson = response['meals'];
      return categoriesJson.map((e) => MealCategory.fromJson(e)).toList();
    } catch (error) {
      throw Exception('Failed to load meal categories');
    }
  }

  Future<List<Meal>> fetchMealsListByCategory(String? strCategory) async {
    try {
      final response = await MealAPiClient.getMealsForParticularCategory(strCategory);
      final List<dynamic> meals = response['meals'];
      List<Meal> mealsList = meals.map((e) => Meal.fromJson(e, strCategory)).toList();
      mealsListByCategory.addAll({'$strCategory': mealsList});
      return mealsList;
    } catch (error) {
      throw Exception('Failed to load meals for $strCategory');
    }
  }

  addToCart(Meal meal) {
    final meals = mealsListByCategory[meal.mealCategory];
    if (meals != null) {
      final index = meals.indexWhere((element) => element.mealId == meal.mealId);
      if (index != -1) {
        meals[index].mealCount = 1;
        mealsListByCategory[meal.mealCategory] = [...meals];
        cartItems.add(meal);
        _refreshMealsList();
      }
    }
  }

  increaseMealCount(
    Meal meal, {
    bool isFromCart = false,
  }) {
    final meals = mealsListByCategory[meal.mealCategory];
    if (meals != null) {
      final index = meals.indexWhere((element) => element.mealId == meal.mealId);
      if (index != -1) {
        meals[index].mealCount += 1;
        mealsListByCategory[meal.mealCategory] = [...meals];
        _refreshMealsList();
      }
    }
  }

  decreaseMealCount(
    Meal meal, {
    bool isFromCart = false,
  }) {
    final meals = mealsListByCategory[meal.mealCategory];
    if (meals != null) {
      final index = meals.indexWhere((element) => element.mealId == meal.mealId);
      if (index != -1 && meals[index].mealCount > 0) {
        meals[index].mealCount -= 1;
        mealsListByCategory[meal.mealCategory] = [...meals];
        if (meals[index].mealCount == 0) {
          removeMealFromCart(meal.mealId);
        }
        _refreshMealsList();
      }
    }
  }

  _refreshMealsList() {
    mealsListByCategory.refresh();
    cartItems.refresh();
  }

  removeMealFromCart(String mealId) {
    cartItems.removeWhere((element) => element.mealId == mealId);
  }

  confirmPlaceOrder() {
    if (cartItems.isEmpty) {
      Fluttertoast.showToast(msg: StringConstants.noItemsToOrder);
      return;
    }
    for (final cartItem in cartItems) {
      final meals = mealsListByCategory[cartItem.mealCategory];
      if (meals != null) {
        final index = meals.indexWhere((meal) => meal.mealId == cartItem.mealId);
        if (index != -1) {
          meals[index].mealCount = 0;
        }
      }
    }
    Fluttertoast.showToast(msg: StringConstants.orderPlacedSuccessfully);
    cartItems.clear();
    _refreshMealsList();
    Get.back();
  }
}
