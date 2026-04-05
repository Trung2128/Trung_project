import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class DrawerScreen extends StatelessWidget {
  final bool? isLoggedIn;
  final VoidCallback onGoToProducts;
  final VoidCallback onGoToFavorites;
  final VoidCallback onLogout;
  final VoidCallback onShowLogin;

  const DrawerScreen({
    super.key,
    required this.isLoggedIn,
    required this.onGoToProducts,
    required this.onGoToFavorites,
    required this.onLogout,
    required this.onShowLogin,
  });

  // Hàm xử lý mở URL
  Future<void> _launchURL(BuildContext context, String url) async {
    final Uri uri = Uri.parse(url.trim());
    try {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } catch (e) {
      debugPrint('Không thể mở link: $e');
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Lỗi: Không thể mở trình duyệt')),
        );
      }
    }
  }

  Widget _authorInfoItem(BuildContext context, String label, String value) {
    bool isLink = value.startsWith('http');

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$label: ",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xFFFF7A00),
            ),
          ),
          Expanded(
            child: InkWell(
              onTap: isLink ? () => _launchURL(context, value) : null,
              child: Text(
                value,
                style: TextStyle(
                  color: isLink ? Colors.blue : Colors.white,
                  decoration: isLink
                      ? TextDecoration.underline
                      : TextDecoration.none,
                ),
                softWrap: true,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.black,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          // --- PHẦN HEADER ĐÃ SỬA LỖI (THẲNG VÀ CÓ TRANG TRÍ) ---
          Container(
            height: 160,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFFF8C00), Color(0xFFFF5E00)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Stack(
              children: [
                // Vòng tròn trang trí mờ bên trái
                Positioned(
                  top: -20,
                  left: -20,
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withOpacity(0.12),
                    ),
                  ),
                ),
                // Vòng tròn trang trí viền bên phải
                Positioned(
                  bottom: -10,
                  right: 15,
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white.withOpacity(0.1),
                        width: 1.5,
                      ),
                    ),
                  ),
                ),
                // Nội dung Avatar và Chữ
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Text(
                        'Menu',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // --- GIỮ NGUYÊN LISTTILE NHƯ GỐC CỦA BẠN ---
          ListTile(
            leading: const Icon(Icons.home, color: Color(0xFFFF7A00)),
            title: const Text(
              'Trang chủ',
              style: TextStyle(color: Colors.white),
            ),
            onTap: () => Navigator.pop(context),
          ),
          ExpansionTile(
            leading: const Icon(Icons.info_outline, color: Color(0xFFFF7A00)),
            iconColor: Colors.white,
            collapsedIconColor: Colors.white70,
            title: const Text(
              'Thông tin tác giả',
              style: TextStyle(color: Colors.white),
            ),
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    _authorInfoItem(
                      context,
                      "Họ và tên",
                      "Nguyễn Quang Trung.",
                    ),
                    _authorInfoItem(context, "Mã sinh viên", "22T1020778."),
                    _authorInfoItem(
                      context,
                      "Lớp",
                      "Lập trình thiết bị di động.",
                    ),
                    _authorInfoItem(
                      context,
                      "GitHub",
                      "https://github.com/Trung2128/Trung_project",
                    ),
                  ],
                ),
              ),
            ],
          ),
          ListTile(
            leading: const Icon(Icons.store_outlined, color: Color(0xFFFF7A00)),
            title: const Text(
              'Thực đơn',
              style: TextStyle(color: Colors.white),
            ),
            onTap: () {
              Navigator.pop(context);
              onGoToProducts();
            },
          ),
          const Divider(color: Colors.white24),
          ListTile(
            leading: Icon(
              isLoggedIn == true ? Icons.logout : Icons.login,
              color: isLoggedIn == true ? Colors.red : Colors.blue,
            ),
            title: Text(
              isLoggedIn == true ? 'Đăng xuất' : 'Đăng nhập',
              style: TextStyle(
                color: isLoggedIn == true ? Colors.red : Colors.blue,
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: () {
              Navigator.pop(context);
              if (isLoggedIn == true) {
                onLogout();
              } else {
                onShowLogin();
              }
            },
          ),
        ],
      ),
    );
  }
}
