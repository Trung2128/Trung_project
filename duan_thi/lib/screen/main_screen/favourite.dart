import 'package:flutter/material.dart';
import 'package:duan_thi/model/favourite_store.dart';
import 'package:duan_thi/model/recipe_model.dart';
import 'package:duan_thi/screen/recipe_screen/recipe_detail.dart';

class FavoriteScreen extends StatefulWidget {
  final bool isLoggedIn;
  final VoidCallback onShowLogin;

  const FavoriteScreen({
    super.key,
    required this.isLoggedIn,
    required this.onShowLogin,
  });

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.black, body: _buildBody());
  }

  // Hàm điều hướng hiển thị các trạng thái
  Widget _buildBody() {
    // 1. Nếu CHƯA đăng nhập (Giữ nguyên logic của bạn)
    if (!widget.isLoggedIn) {
      return _buildLoginRequiredState();
    }

    // 2. Dùng Builder để tự động cập nhật khi danh sách thay đổi
    return ValueListenableBuilder<List<Recipe>>(
      valueListenable: FavoriteStore.favoritesNotifier,
      builder: (context, favoriteRecipes, _) {
        // Check danh sách trống bên trong builder
        if (favoriteRecipes.isEmpty) {
          return _buildEmptyState();
        }

        // 3. Nếu CÓ món ăn
        return _buildFavoriteList(favoriteRecipes);
      },
    );
  }

  // --- TRẠNG THÁI CHƯA ĐĂNG NHẬP (Phần của bạn) ---
  Widget _buildLoginRequiredState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: const BoxDecoration(
                color: Color(0xFF1E1E1E),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.favorite_border_rounded,
                size: 80,
                color: Color(0xFFFF7A00),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Đăng nhập để xem yêu thích!',
              style: TextStyle(
                color: Color(0xFFFF7A00),
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Lưu lại những món ăn ngon mà bạn yêu thích nhất tại đây.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white60, fontSize: 15),
            ),
            const SizedBox(height: 30),
            OutlinedButton.icon(
              onPressed: widget.onShowLogin, // Gọi hàm mở dialog đăng nhập
              icon: const Icon(Icons.login, color: Colors.white),
              label: const Text(
                'Đăng nhập ngay',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              style: OutlinedButton.styleFrom(
                backgroundColor: const Color(0xFFFF7A00),
                side: const BorderSide(color: Color(0xFFFF7A00), width: 1.5),
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 14,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- TRẠNG THÁI TRỐNG (Đã đăng nhập nhưng chưa có món) ---
  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: const BoxDecoration(
              color: Color(0xFF1E1E1E),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.no_meals_outlined,
              size: 80,
              color: Color(0xFFFF7A00),
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'Chưa có món tủ nào!',
            style: TextStyle(
              color: Color(0xFFFF7A00),
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Góc yêu thích đang chờ bạn lấp đầy...',
            style: TextStyle(color: Colors.white38, fontSize: 15),
          ),
        ],
      ),
    );
  }

  // --- HIỂN THỊ DANH SÁCH (Giữ nguyên ListView đã viết trước đó) ---
  // --- HIỂN THỊ DANH SÁCH ---
  Widget _buildFavoriteList(List<Recipe> recipes) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: recipes.length,
      itemBuilder: (context, index) {
        final recipe = recipes[index];
        return Card(
          color: const Color(0xFF1A1A1A),
          margin: const EdgeInsets.only(bottom: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
            leading: Hero(
              tag:
                  'recipe-image-${recipe.id}', // Thêm Hero để hiệu ứng mượt hơn
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  recipe.image,
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) =>
                      const Icon(Icons.restaurant, color: Colors.grey),
                ),
              ),
            ),
            title: Text(
              recipe.name,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
              '${recipe.cuisine} • ${recipe.difficulty}',
              style: const TextStyle(color: Colors.grey),
            ),
            trailing: IconButton(
              icon: const Icon(Icons.favorite, color: Colors.red),
              onPressed: () => FavoriteStore.toggle(
                recipe,
              ), // Không cần setState vì ValueListenableBuilder sẽ lo
            ),
            onTap: () {
              // Chuyển sang màn hình chi tiết
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => RecipeDetailScreen(
                    // Vì RecipeDetailScreen nhận Map nên mình dùng toJson()
                    recipe: recipe.toJson(),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
