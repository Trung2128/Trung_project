import 'package:flutter/material.dart';
import 'package:duan_thi/api/recipe_api.dart'; // Đổi tên file service cho đúng
import 'package:duan_thi/screen/recipe_screen/recipe_detail.dart'; // Màn hình chi tiết công thức

class RecipeScreen extends StatefulWidget {
  const RecipeScreen({super.key});

  @override
  State<RecipeScreen> createState() => _RecipeListScreenState();
}

class _RecipeListScreenState extends State<RecipeScreen> {
  // Đổi sang RecipeService
  final _service = RecipeApi();
  final _searchController = TextEditingController();
  final _scrollController = ScrollController();

  List<Map<String, dynamic>> _recipes = [];
  bool _isLoading = false;
  bool _isLoadingMore = false;
  bool _hasMore = true;
  String _error = '';
  String _searchQuery = '';

  int _skip = 0;
  static const int _limit = 20;

  @override
  void initState() {
    super.initState();
    _loadRecipes();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_searchQuery.isNotEmpty) return;
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 200 &&
        !_isLoadingMore &&
        _hasMore) {
      _loadMore();
    }
  }

  Future<void> _loadRecipes() async {
    setState(() {
      _isLoading = true;
      _error = '';
      _skip = 0;
      _hasMore = true;
    });
    try {
      final data = await _service.getRecipes(limit: _limit, skip: 0);
      if (!mounted) return;
      setState(() {
        _recipes = data;
        _skip = data.length;
        _hasMore = data.length == _limit;
        _isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  Future<void> _loadMore() async {
    setState(() => _isLoadingMore = true);
    try {
      final data = await _service.getRecipes(limit: _limit, skip: _skip);
      if (!mounted) return;
      setState(() {
        _recipes.addAll(data);
        _hasMore = data.length == _limit;
        _isLoadingMore = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() => _isLoadingMore = false);
    }
  }

  Future<void> _search(String query) async {
    setState(() {
      _searchQuery = query;
      _isLoading = true;
      _error = '';
    });
    try {
      final data = query.isEmpty
          ? await _service.getRecipes(limit: _limit, skip: 0)
          : await _service.searchRecipes(query);
      if (!mounted) return;
      setState(() {
        _recipes = data;
        _skip = data.length;
        _hasMore = query.isEmpty && data.length == _limit;
        _isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  void _clearSearch() {
    _searchController.clear();
    _search('');
  }

  void _openDetail(Map<String, dynamic> recipe) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => RecipeDetailScreen(recipe: recipe)),
    ).then((_) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 1. ĐỔI NỀN CẢ TRANG PHÍA DƯỚI THÀNH MÀU ĐEN
      backgroundColor: Colors.black,

      appBar: AppBar(
        title: const Text(
          'Công thức nấu ăn',
          style: TextStyle(
            color: Colors.white, // Chữ trắng trên nền cam sẽ nổi hơn
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,

        // 2. GIỮ MÀU GRADIENT CAM CHO APPBAR TẠI ĐÂY
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFFF8C00), Color(0xFFFF5E00)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),

        // Thanh tìm kiếm nằm ở phần bottom của AppBar
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
            child: TextField(
              controller: _searchController,
              onChanged: (v) => _search(v.trim()),
              decoration: InputDecoration(
                hintText: 'Tìm món ăn, nguyên liệu...',
                prefixIcon: const Icon(
                  Icons.restaurant,
                  color: Color(0xFFFF7A00),
                ),
                suffixIcon: _searchQuery.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: _clearSearch,
                      )
                    : null,
                filled: true,
                fillColor: Colors.white, // Ô search màu trắng cho dễ nhìn
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
        ),
      ),

      // 3. PHẦN BODY SẼ CÓ NỀN ĐEN (do thiết lập ở Scaffold)
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(color: Colors.orange),
      );
    }
    if (_error.isNotEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 48, color: Colors.red),
            const SizedBox(height: 12),
            Text(_error, textAlign: TextAlign.center),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: _loadRecipes,
              icon: const Icon(Icons.refresh),
              label: const Text('Thử lại'),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
            ),
          ],
        ),
      );
    }
    if (_recipes.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.restaurant_menu, size: 64, color: Colors.grey),
            const SizedBox(height: 12),
            Text(
              _searchQuery.isNotEmpty
                  ? 'Không tìm thấy "$_searchQuery"'
                  : 'Không có công thức nào',
              style: const TextStyle(color: Colors.grey),
            ),
          ],
        ),
      );
    }
    return RefreshIndicator(
      color: Colors.orange,
      onRefresh: _loadRecipes,
      child: ListView.separated(
        controller: _scrollController,
        padding: const EdgeInsets.all(12),
        itemCount: _recipes.length + (_isLoadingMore ? 1 : 0),
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (_, i) {
          if (i == _recipes.length) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: CircularProgressIndicator(color: Colors.orange),
              ),
            );
          }
          return _buildRecipeCard(_recipes[i]);
        },
      ),
    );
  }

  Widget _buildRecipeCard(Map<String, dynamic> recipe) {
    // Các key từ API Recipe của DummyJSON
    final name = recipe['name'] ?? '';
    final difficulty = recipe['difficulty'] ?? '';
    final cuisine = recipe['cuisine'] ?? '';
    final rating = (recipe['rating'] as num?)?.toDouble() ?? 0.0;
    final calories = recipe['caloriesPerServing'] ?? 0;
    final image = recipe['image'] as String?;
    final prepTime = recipe['prepTimeMinutes'] ?? 0;

    return Card(
      color: Colors.black,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: () => _openDetail(recipe),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Hero(
                  tag:
                      'recipe-image-${recipe['id']}', // Tag duy nhất cho mỗi món ăn
                  child: image != null
                      ? Image.network(
                          image,
                          width: 90,
                          height: 90,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => _placeholderImage(),
                        )
                      : _placeholderImage(),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '$cuisine • $difficulty',
                      style: const TextStyle(color: Colors.grey, fontSize: 13),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(
                          Icons.timer_outlined,
                          size: 14,
                          color: Colors.orange,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '$prepTime phút',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(width: 12),
                        const Icon(
                          Icons.local_fire_department,
                          size: 14,
                          color: Colors.redAccent,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '$calories kcal',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(Icons.star, size: 14, color: Colors.amber),
                        const SizedBox(width: 2),
                        Text(
                          rating.toStringAsFixed(1),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }

  Widget _placeholderImage() {
    return Container(
      width: 90,
      height: 90,
      color: Colors.grey.shade200,
      child: const Icon(Icons.restaurant, color: Colors.grey),
    );
  }
}
