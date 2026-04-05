import 'package:flutter/material.dart';
import 'package:duan_thi/model/favourite_store.dart';
import 'package:duan_thi/model/recipe_model.dart';
import 'package:duan_thi/api/auth.dart';
import 'package:duan_thi/screen/login_screen/register_login.dart';

class RecipeDetailScreen extends StatefulWidget {
  final Map<String, dynamic> recipe;

  const RecipeDetailScreen({super.key, required this.recipe});

  @override
  State<RecipeDetailScreen> createState() => _RecipeDetailScreenState();
}

class _RecipeDetailScreenState extends State<RecipeDetailScreen> {
  bool _isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  void _checkLoginStatus() async {
    bool loggedIn = await Auth().isLoggedIn();
    if (mounted) {
      setState(() {
        _isLoggedIn = loggedIn;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final r = widget.recipe;
    final id = (r['id'] as num?)?.toInt() ?? 0;
    final name = r['name'] ?? '';

    // Lấy dữ liệu gốc không qua hàm dịch
    final ingredients = (r['ingredients'] as List? ?? [])
        .map((e) => e.toString())
        .toList();
    final instructions = (r['instructions'] as List? ?? [])
        .map((e) => e.toString())
        .toList();

    final prepTime = r['prepTimeMinutes'] ?? 0;
    final cookTime = r['cookTimeMinutes'] ?? 0;
    final servings = r['servings'] ?? 0;
    final difficulty = r['difficulty'] ?? 'Easy';
    final cuisine = r['cuisine'] ?? '';
    final calories = r['caloriesPerServing'] ?? 0;
    final image = r['image'] as String?;
    final rating = (r['rating'] as num?)?.toDouble() ?? 0.0;
    final reviewCount = r['reviewCount'] ?? 0;

    final recipeModel = Recipe(
      id: id,
      name: name,
      image: image ?? '',
      rating: rating,
      cuisine: cuisine,
      difficulty: difficulty,
      caloriesPerServing: calories,
      ingredients: ingredients,
      instructions: instructions,
      prepTimeMinutes: prepTime,
      cookTimeMinutes: cookTime,
      servings: servings,
      reviewCount: reviewCount,
    );

    return Scaffold(
      backgroundColor: Colors.black,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            backgroundColor: Colors.black,
            flexibleSpace: FlexibleSpaceBar(
              background: image != null
                  ? Image.network(image, fit: BoxFit.cover)
                  : const Icon(
                      Icons.restaurant,
                      size: 100,
                      color: Colors.white,
                    ),
            ),
            actions: [
              ValueListenableBuilder<List<Recipe>>(
                valueListenable: FavoriteStore.favoritesNotifier,
                builder: (context, favorites, _) {
                  final isCurrentlyFav = favorites.any(
                    (element) => element.id == id,
                  );
                  return CircleAvatar(
                    backgroundColor: Colors.white,
                    child: IconButton(
                      icon: Icon(
                        isCurrentlyFav ? Icons.favorite : Icons.favorite_border,
                        color: isCurrentlyFav ? Colors.red : Colors.grey,
                      ),
                      onPressed: () {
                        if (!_isLoggedIn) {
                          RequireLogin.showLoginDialog(context);
                        } else {
                          FavoriteStore.toggle(recipeModel);
                          // Không cần setState ở đây nữa vì ValueListenableBuilder sẽ lo
                        }
                      },
                    ),
                  );
                },
              ),
              const SizedBox(width: 10),
            ],
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      _buildInfoChip(
                        Icons.star,
                        Colors.amber,
                        '$rating ($reviewCount reviews)',
                      ),
                      const SizedBox(width: 8),
                      _buildInfoChip(Icons.flag_outlined, Colors.blue, cuisine),
                      const SizedBox(width: 8),
                      _buildInfoChip(Icons.bolt, Colors.orange, difficulty),
                    ],
                  ),
                  const Divider(height: 32, color: Colors.white24),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildMetric(
                        Icons.timer,
                        '${prepTime + cookTime} min',
                        'Time',
                      ),
                      _buildMetric(Icons.restaurant, '$servings', 'Servings'),
                      _buildMetric(
                        Icons.local_fire_department,
                        '$calories',
                        'Calories',
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),
                  const Text(
                    'Ingredients',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  ...ingredients.map(
                    (item) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.check_circle_outline,
                            size: 18,
                            color: Colors.orange,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              item,
                              style: const TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),
                  const Text(
                    'Instructions',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  ...instructions.asMap().entries.map((entry) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            radius: 12,
                            backgroundColor: Colors.orange,
                            child: Text(
                              '${entry.key + 1}',
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              entry.value,
                              style: const TextStyle(
                                fontSize: 15,
                                height: 1.5,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoChip(IconData icon, Color color, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(icon, size: 16, color: color),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMetric(IconData icon, String value, String label) {
    return Column(
      children: [
        Icon(icon, color: Colors.orange, size: 28),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: Colors.white,
          ),
        ),
        Text(
          label,
          style: const TextStyle(color: Colors.white70, fontSize: 12),
        ),
      ],
    );
  }
}
