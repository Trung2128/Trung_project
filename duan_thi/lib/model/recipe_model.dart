class Recipe {
  final int id;
  final String name;
  final String image;
  final double rating;
  final String cuisine;
  final String difficulty;
  final int caloriesPerServing;
  final List<String> ingredients;
  final List<String> instructions;
  final int prepTimeMinutes;
  final int cookTimeMinutes;
  final int servings;
  final int reviewCount;

  Recipe({
    required this.id,
    required this.name,
    required this.image,
    required this.rating,
    required this.cuisine,
    required this.difficulty,
    required this.caloriesPerServing,
    required this.ingredients,
    required this.instructions,
    required this.prepTimeMinutes,
    required this.cookTimeMinutes,
    required this.servings,
    required this.reviewCount,
  });

  // --- THÊM ĐOẠN NÀY VÀO ---
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'rating': rating,
      'cuisine': cuisine,
      'difficulty': difficulty,
      'caloriesPerServing': caloriesPerServing,
      'ingredients': ingredients,
      'instructions': instructions,
      'prepTimeMinutes': prepTimeMinutes,
      'cookTimeMinutes': cookTimeMinutes,
      'servings': servings,
      'reviewCount': reviewCount,
    };
  }
}
