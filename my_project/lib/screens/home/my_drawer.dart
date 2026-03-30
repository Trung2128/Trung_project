import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:my_project/screens/login/my_login.dart';
import 'package:my_project/screens/home/my_app.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  final Color primaryColor = const Color(0xFF0CB39F);

  // Hàm hiển thị hộp thoại xác nhận đăng xuất
  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Xác nhận"),
        content: const Text("Bạn có chắc chắn muốn đăng xuất không?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Hủy", style: TextStyle(color: Colors.grey)),
          ),
          TextButton(
            onPressed: () async {
              final prefs = await SharedPreferences.getInstance();
              await prefs.remove("token");

              if (!context.mounted) return;
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const LoginScreen()),
                (route) => false,
              );
            },
            child: const Text("Đăng xuất", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        // Chuyển sang Column để có thể đẩy nút Đăng xuất xuống cuối nếu muốn
        children: [
          // Header Menu
          Container(
            width: double.infinity,
            height: 120,
            padding: const EdgeInsets.only(left: 16, bottom: 20),
            decoration: BoxDecoration(
              color: primaryColor,
              image: const DecorationImage(
                image: NetworkImage(
                  "https://www.transparenttextures.com/patterns/cubes.png",
                ), // Thêm texture nhẹ cho đẹp
                repeat: ImageRepeat.repeat,
                opacity: 0.1,
              ),
            ),
            child: const Align(
              alignment: Alignment.bottomLeft,
              child: Text(
                "MENU",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                ),
              ),
            ),
          ),

          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                // App Settings
                ListTile(
                  leading: Icon(
                    Icons.settings_suggest_outlined,
                    color: primaryColor,
                  ),
                  title: const Text("Ứng dụng"),
                  onTap: () {
                    Navigator.pop(context); // Đóng Drawer/Menu trước
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AppScreen(),
                      ),
                    );
                  },
                ),

                // Thông tin tác giả (Sử dụng ExpansionTile cho chuyên nghiệp)
                ExpansionTile(
                  leading: Icon(Icons.info_outline, color: primaryColor),
                  title: const Text("Thông tin tác giả"),
                  iconColor: primaryColor,
                  textColor: primaryColor,
                  children: [
                    Container(
                      width: double.infinity,
                      margin: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey.shade200),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Nguyễn Quang Trung",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          const Divider(height: 20),
                          _buildInfoRow(
                            Icons.badge_outlined,
                            "MSV: 22T1020778",
                          ),
                          const SizedBox(height: 8),
                          _buildInfoRow(
                            Icons.class_outlined,
                            "Lớp: Lập trình di động",
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Nút Đăng xuất ở dưới cùng
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout_rounded, color: Colors.redAccent),
            title: const Text(
              "Đăng xuất",
              style: TextStyle(
                color: Colors.redAccent,
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: () => _showLogoutDialog(context),
          ),
          const SizedBox(
            height: 20,
          ), // Khoảng cách an toàn cho các máy có thanh điều hướng
        ],
      ),
    );
  }

  // Widget phụ trợ để hiển thị dòng thông tin nhỏ
  Widget _buildInfoRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 16, color: Colors.black54),
        const SizedBox(width: 8),
        Text(text, style: const TextStyle(color: Colors.black54, fontSize: 14)),
      ],
    );
  }
}
