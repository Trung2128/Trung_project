import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  final VoidCallback onGoToProducts;
  final VoidCallback onShowLogin;
  final bool isLoggedIn; // Nhận trạng thái từ file cha

  const HomeScreen({
    super.key,
    required this.onGoToProducts,
    required this.onShowLogin,
    required this.isLoggedIn,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Icon trang chủ
          Container(
            padding: const EdgeInsets.all(24),
            decoration: const BoxDecoration(
              color: Color(0xFF1E1E1E),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.food_bank_rounded,
              size: 80,
              color: Color(0xFFFF7A00),
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'Chào mừng bạn trở lại!',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Color(0xFFFF7A00),
            ),
          ),
          const SizedBox(height: 20),

          // Nút Xem thực đơn (Luôn hiện)
          OutlinedButton.icon(
            onPressed: onGoToProducts,
            icon: const Icon(Icons.soup_kitchen, color: Color(0xFFFF7A00)),
            label: const Text(
              'Xem thực đơn',
              style: TextStyle(
                color: Color(0xFFFF7A00),
                fontWeight: FontWeight.bold,
              ),
            ),
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: Color(0xFFFF7A00), width: 1.5),
              padding: const EdgeInsets.symmetric(horizontal: 45, vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          const SizedBox(height: 3),
          // CHỈ HIỆN NÚT ĐĂNG NHẬP NẾU isLoggedIn == false
          if (isLoggedIn == false) ...[
            const SizedBox(height: 16),
            OutlinedButton.icon(
              onPressed: onShowLogin,
              icon: const Icon(
                Icons.login,
                color: Colors.white, // Màu trắng cho icon
              ),
              label: const Text(
                'Đăng nhập ngay',
                style: TextStyle(
                  color: Colors.white, // Màu trắng cho chữ
                  fontWeight: FontWeight.bold,
                ),
              ),
              style: OutlinedButton.styleFrom(
                backgroundColor: const Color(
                  0xFFFF7A00,
                ), // ĐỔ MÀU CAM VÀO TRONG NỀN
                side: const BorderSide(
                  color: Color(0xFFFF7A00),
                  width: 1.5,
                ), // Viền cam
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 14,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 2, // Thêm độ nổi một chút cho đẹp
              ),
            ),
          ],
        ],
      ),
    );
  }
}
