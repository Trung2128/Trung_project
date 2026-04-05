class Recipe {
  final int id;
  final String name;
  final List<String> ingredients;    // Danh sách nguyên liệu
  final List<String> instructions;   // Các bước thực hiện
  final int prepTimeMinutes;         // Thời gian chuẩn bị
  final int cookTimeMinutes;         // Thời gian nấu
  final int servings;                // Khẩu phần (số người ăn)
  final String difficulty;           // Độ khó (Easy, Medium...)
  final String cuisine;              // Loại ẩm thực (Italian, Asian...)
  final int caloriesPerServing;      // Calo mỗi phần
  final String image;                // Hình ảnh món ăn
  final double rating;               // Đánh giá
  final int reviewCount;             // Số lượng đánh giá

  Recipe({
    required this.id,
    required this.name,
    required this.ingredients,
    required this.instructions,
    required this.prepTimeMinutes,
    required this.cookTimeMinutes,
    required this.servings,
    required this.difficulty,
    required this.cuisine,
    required this.caloriesPerServing,
    required this.image,
    required this.rating,
    required this.reviewCount,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      // Ép kiểu List<dynamic> từ JSON sang List<String>
      ingredients: List<String>.from(json['ingredients'] ?? []),
      instructions: List<String>.from(json['instructions'] ?? []),
      prepTimeMinutes: json['prepTimeMinutes'] ?? 0,
      cookTimeMinutes: json['cookTimeMinutes'] ?? 0,
      servings: json['servings'] ?? 0,
      difficulty: json['difficulty'] ?? 'Dễ',
      cuisine: json['cuisine'] ?? '',
      caloriesPerServing: json['caloriesPerServing'] ?? 0,
      image: json['image'] ?? '',
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      reviewCount: json['reviewCount'] ?? 0,
    );
  }
}