import 'package:flutter/material.dart';
import '../../models/book_model.dart';
import '../../services/book_service.dart';
import '../../screens/home/my_reading.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Book> _displayedBooks = [];
  String selectedCategory = 'Tất cả';
  bool _isLoading = true; // Quản lý trạng thái loading thay cho FutureBuilder
  final TextEditingController _searchController = TextEditingController();
  final Color primaryColor = const Color(0xFF0CB39F);

  final List<String> categories = [
    'Tất cả',
    'Văn học',
    'Kỹ năng',
    'Manga',
    'Khoa học',
  ];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  // Nạp dữ liệu từ Service vào kho static và hiển thị
  Future<void> _loadData() async {
    try {
      await BookService().initsData();
      if (mounted) {
        setState(() {
          _displayedBooks = Book.allBooks; // Lấy dữ liệu từ kho chung
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
      }
      debugPrint("Lỗi load dữ liệu: $e");
    }
  }

  // Logic lọc sách: Luôn lọc dựa trên "kho tổng" Book.allBooks
  void _runFilter() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _displayedBooks = Book.allBooks.where((book) {
        final titleMatch = book.title.toLowerCase().contains(query);
        final categoryMatch =
            selectedCategory == 'Tất cả' || book.category == selectedCategory;
        return titleMatch && categoryMatch;
      }).toList();
    });
  }

  void _openBook(Book book) {
    if (book.status.isEmpty) {
      book.status = 'reading';
    }

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ReadingScreen(book: book)),
    ).then((_) {
      // Khi quay lại từ màn hình đọc, ép trang chủ cập nhật lại UI
      if (mounted) setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: Column(
        children: [
          _buildSearchField(),
          _buildCategoryBar(),
          Expanded(
            child: _isLoading
                ? Center(child: CircularProgressIndicator(color: primaryColor))
                : _displayedBooks.isEmpty
                ? _buildEmptyState()
                : GridView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.62,
                          crossAxisSpacing: 15,
                          mainAxisSpacing: 15,
                        ),
                    itemCount: _displayedBooks.length,
                    itemBuilder: (context, index) =>
                        _buildBookCard(_displayedBooks[index]),
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildBookCard(Book book) {
    return Card(
      elevation: 3,
      shadowColor: Colors.black26,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => _openBook(book),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    book.image,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      color: Colors.grey[200],
                      child: const Icon(Icons.book, color: Colors.grey),
                    ),
                  ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: _buildFavoriteButton(book),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    book.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    book.author,
                    style: TextStyle(color: Colors.grey[600], fontSize: 11),
                    maxLines: 1,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFavoriteButton(Book book) {
    return GestureDetector(
      onTap: () {
        setState(() {
          book.isFav = !book.isFav;
        });
      },
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.9),
          shape: BoxShape.circle,
        ),
        child: Icon(
          book.isFav ? Icons.favorite : Icons.favorite_border,
          color: Colors.red,
          size: 18,
        ),
      ),
    );
  }

  Widget _buildSearchField() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
      child: TextField(
        controller: _searchController,
        onChanged: (_) => _runFilter(),
        decoration: InputDecoration(
          hintText: 'Tìm kiếm sách...',
          prefixIcon: Icon(Icons.search, color: primaryColor),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 20),
        ),
      ),
    );
  }

  Widget _buildCategoryBar() {
    return SizedBox(
      height: 55,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final cat = categories[index];
          final isSelected = selectedCategory == cat;
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: ChoiceChip(
              label: Text(cat),
              selected: isSelected,
              onSelected: (val) {
                if (val) {
                  selectedCategory = cat;
                  _runFilter();
                }
              },
              selectedColor: primaryColor,
              labelStyle: TextStyle(
                color: isSelected ? Colors.white : Colors.black,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildEmptyState() =>
      const Center(child: Text("Không tìm thấy sách nào"));
}
