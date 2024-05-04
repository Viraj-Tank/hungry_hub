class MealCategory {
  String? mealCategory;

  MealCategory({
    this.mealCategory,
  });

  factory MealCategory.fromJson(Map<String, dynamic> json) {
    return MealCategory(
      mealCategory: json['strCategory'],
    );
  }
}
