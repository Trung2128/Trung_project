import 'package:flutter/material.dart';
import '../../models/book_model.dart';

class ReadingScreen extends StatefulWidget {
  final Book book;

  const ReadingScreen({super.key, required this.book});

  @override
  State<ReadingScreen> createState() => _ReadingScreenState();
}

class _ReadingScreenState extends State<ReadingScreen> {
  // Cố định thông số hiển thị
  final double _fontSize = 18.0;
  final Color _primaryColor = const Color(0xFF0CB39F);

  @override
  Widget build(BuildContext context) {
    // Truy cập trực tiếp qua thuộc tính của class Book (không cần ép kiểu hay check null an toàn như Map)
    final String title = widget.book.title;
    final String content = widget.book.content;
    final String status = widget.book.status;

    return Scaffold(
      backgroundColor: const Color(0xFFFDF6E3), // Màu nền giấy dịu mắt
      appBar: AppBar(
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: _primaryColor,
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Tiêu đề sách trong nội dung
              Text(
                title,
                style: TextStyle(
                  fontSize: _fontSize + 6,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const Divider(height: 40, thickness: 1.2),

              // Nội dung chính
              Text(
                content,
                style: TextStyle(
                  fontSize: _fontSize,
                  height: 1.8,
                  color: Colors.black87,
                ),
              ),

              const SizedBox(height: 60),

              // Khu vực nút bấm hoặc thông báo kết thúc
              _buildStatusFooter(status),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusFooter(String status) {
    if (status != 'completed') {
      return Center(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 40),
          child: ElevatedButton.icon(
            onPressed: () {
              // Cập nhật trạng thái vào object Book
              setState(() {
                widget.book.status = 'completed';
              });

              // Thông báo cho người dùng
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Chúc mừng! Bạn đã hoàn thành cuốn sách này."),
                  backgroundColor: Color(0xFF0CB39F),
                  duration: Duration(seconds: 2),
                ),
              );

              // Quay lại màn hình trước
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: _primaryColor,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              elevation: 3,
            ),
            icon: const Icon(Icons.check_circle_outline),
            label: const Text(
              "Đã đọc xong",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      );
    } else {
      return const Center(
        child: Padding(
          padding: EdgeInsets.only(bottom: 40),
          child: Text(
            "--- Bạn đã hoàn thành cuốn sách này ---",
            style: TextStyle(
              color: Colors.grey,
              fontStyle: FontStyle.italic,
              fontSize: 15,
            ),
          ),
        ),
      );
    }
  }
}
