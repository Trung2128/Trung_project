import 'package:flutter/material.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  final Color primaryColor = const Color(0xFF0CB39F);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        title: const Text(
          'Trung tâm trợ giúp',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: primaryColor,
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Chúng tôi có thể giúp gì cho bạn?',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            const Text(
              'Câu hỏi thường gặp',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 10),
            _buildFAQTile('Làm thế nào để tải sách về máy?'),
            _buildFAQTile('Tôi có thể đổi cỡ chữ khi đang đọc không?'),
            _buildFAQTile('Làm sao để đồng bộ dữ liệu trên thiết bị khác?'),
            _buildFAQTile('Chính sách bảo mật thông tin như thế nào?'),

            const SizedBox(height: 30),
            const Text(
              'Liên hệ hỗ trợ',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 10),
            Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
                side: BorderSide(color: Colors.grey.shade200),
              ),
              child: Column(
                children: [
                  _buildContactTile(
                    Icons.email_outlined,
                    'Gửi Email',
                    'nguyenquangtrung1357@gmail.com',
                    Colors.blue,
                  ),
                  const Divider(height: 1, indent: 50),
                  _buildContactTile(
                    Icons.phone_outlined,
                    'Tổng đài hỗ trợ',
                    '0386542526',
                    primaryColor,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactTile(
    IconData icon,
    String title,
    String subtitle,
    Color iconColor,
  ) {
    return ListTile(
      leading: Icon(icon, color: iconColor),
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
      ),
      subtitle: Text(subtitle, style: const TextStyle(fontSize: 13)),
    );
  }

  Widget _buildFAQTile(String question) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      child: ExpansionTile(
        shape: const Border(), // Xóa gạch ngang khi mở rộng
        title: Text(
          question,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        ),
        children: const [
          Padding(
            padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Text(
              'Hiện tại chúng tôi đang cập nhật nội dung cho câu hỏi này. Vui lòng liên hệ hotline để được hỗ trợ trực tiếp.',
              style: TextStyle(color: Colors.grey, fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }
}
