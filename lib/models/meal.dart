class Meal {
  final String mealName;
  final String mealThumbnail;
  final String mealId;
  final double mealPrice;
  final String mealCategory;
  int mealCount;

  Meal({
    required this.mealName,
    required this.mealThumbnail,
    required this.mealId,
    required this.mealPrice,
    required this.mealCategory,
    this.mealCount = 0,
  });

  factory Meal.fromJson(
    Map<String, dynamic> json,
    String? strCategory,
  ) {
    return Meal(
      mealName: json['strMeal'],
      mealThumbnail: json['strMealThumb'],
      mealId: json['idMeal'],
      mealCategory: strCategory ?? '',
      mealPrice: 50,
    );
  }

  Meal copyWith({
    String? mealName,
    String? mealThumbnail,
    String? mealId,
    double? mealPrice,
    String? mealCategory,
    int? mealCount,
  }) {
    return Meal(
      mealName: mealName ?? this.mealName,
      mealThumbnail: mealThumbnail ?? this.mealThumbnail,
      mealId: mealId ?? this.mealId,
      mealPrice: mealPrice ?? this.mealPrice,
      mealCategory: mealCategory ?? this.mealCategory,
      mealCount: mealCount ?? this.mealCount,
    );
  }
}
