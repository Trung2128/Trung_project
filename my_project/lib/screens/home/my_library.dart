import 'package:flutter/material.dart';
import '../../models/book_model.dart';
import '../../services/book_service.dart';
import '../../screens/home/my_reading.dart';

class LibraryScreen extends StatefulWidget {
  const LibraryScreen({super.key});

  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final Color primaryColor = const Color(0xFF0CB39F);
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _initData();
  }

  // Load dữ liệu lần đầu tiên nếu kho static trống
  Future<void> _initData() async {
    if (Book.allBooks.isEmpty) {
      await BookService().initsData();
    }
    if (mounted) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // QUAN TRỌNG: Lọc dữ liệu ngay trong hàm build để luôn lấy giá trị isFav mới nhất
    final readingBooks = Book.allBooks
        .where((b) => b.status == 'reading')
        .toList();
    final completedBooks = Book.allBooks
        .where((b) => b.status == 'completed')
        .toList();
    final favoriteBooks = Book.allBooks.where((b) => b.isFav).toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7F9),
      body: Column(
        children: [
          Material(
            elevation: 1,
            color: primaryColor,
            child: TabBar(
              controller: _tabController,
              indicatorColor: Colors.white,
              labelColor: Colors.white,
              unselectedLabelColor: Colors.white.withOpacity(0.7),
              tabs: const [
                Tab(text: 'Đang đọc'),
                Tab(text: 'Đã xong'),
                Tab(text: 'Yêu thích'),
              ],
            ),
          ),
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : TabBarView(
                    controller: _tabController,
                    children: [
                      _buildBookList(
                        readingBooks,
                        "Chưa có sách đang đọc",
                        Icons.menu_book,
                      ),
                      _buildBookList(
                        completedBooks,
                        "Chưa có sách hoàn thành",
                        Icons.check_circle,
                      ),
                      _buildBookList(
                        favoriteBooks,
                        "Chưa có sách yêu thích",
                        Icons.favorite,
                      ),
                    ],
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildBookList(List<Book> books, String msg, IconData icon) {
    if (books.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 64, color: Colors.grey.shade300),
            Text(msg, style: TextStyle(color: Colors.grey.shade500)),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: books.length,
      itemBuilder: (context, index) {
        final book = books[index];
        return Card(
          child: ListTile(
            leading: Image.network(book.image, width: 50, fit: BoxFit.cover),
            title: Text(
              book.title,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(book.author),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ReadingScreen(book: book),
                ),
              ).then((_) {
                // Khi từ màn hình đọc quay lại, ép Library lọc lại danh sách isFav
                if (mounted) setState(() {});
              });
            },
          ),
        );
      },
    );
  }
}
