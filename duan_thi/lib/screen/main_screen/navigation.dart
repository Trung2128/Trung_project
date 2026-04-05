import 'package:flutter/material.dart';
import 'package:duan_thi/screen/main_screen/home.dart';
import 'package:duan_thi/screen/main_screen/favourite.dart';
import 'package:duan_thi/screen/recipe_screen/recipe.dart';
import 'package:duan_thi/screen/main_screen/profile.dart';
import 'package:duan_thi/screen/main_screen/drawer.dart';
import 'package:duan_thi/screen/login_screen/register_login.dart';
import 'package:duan_thi/api/auth.dart'; // Sử dụng AuthService từ đây

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({super.key});

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  int _selectedIndex = 0;
  bool _isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  // 1. Kiểm tra trạng thái đăng nhập thực tế từ Token lưu trong máy
  Future<void> _checkLoginStatus() async {
    final loggedIn = await Auth().isLoggedIn();
    if (!mounted) return;
    setState(() {
      _isLoggedIn = loggedIn;
    });
  }

  // 2. Hàm hiển thị Dialog thông báo (Gọi từ trang con hoặc AppBar)
  void _handleShowLogin() {
    RequireLogin.showLoginDialog(context);
  }

  // 3. Hàm lấy Profile thật thông qua AuthService
  // 3. Hàm lấy Profile thật thông qua AuthService
  Future<void> _handleGoToProfile() async {
    if (!_isLoggedIn) {
      _handleShowLogin();
      return;
    }

    // Gọi API "Me" (Không cần truyền token thủ công nữa)
    final profile = await Auth().getProfile(); 

    if (profile != null && mounted) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => ProfileScreen(profile: profile)),
      );
    } else {
      // Nếu lỗi (ví dụ: token hết hạn trên server)
      _handleShowLogin();
    }
  }

  void _goToProducts() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const RecipeScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Truyền dữ liệu đồng bộ xuống các trang con
    final List<Widget> _pages = [
      HomeScreen(
        isLoggedIn: _isLoggedIn,
        onShowLogin: _handleShowLogin,
        onGoToProducts: _goToProducts,
      ),
      FavoriteScreen(isLoggedIn: _isLoggedIn, onShowLogin: _handleShowLogin),
    ];

    return Scaffold(
      backgroundColor: Colors.black,

      // --- DRAWER ---
      drawer: DrawerScreen(
        isLoggedIn: _isLoggedIn,
        onGoToProducts: _goToProducts,
        onGoToFavorites: () {
          Navigator.pop(context);
          setState(() => _selectedIndex = 1);
        },
        onLogout: () async {
          await Auth().logout(); // Xóa token qua API
          _checkLoginStatus(); // Cập nhật lại UI ngay lập tức
        },
        onShowLogin: _handleShowLogin,
      ),

      // --- APPBAR ---
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'Thư viện ẩm thực',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: InkWell(
              onTap: _handleGoToProfile,
              borderRadius: BorderRadius.circular(20),
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  const CircleAvatar(
                    radius: 18,
                    backgroundColor: Colors.white24,
                    child: Icon(Icons.person, color: Colors.white, size: 20),
                  ),
                  // Hiển thị ổ khóa nếu chưa đăng nhập
                  if (_isLoggedIn == false)
                    Container(
                      padding: const EdgeInsets.all(2),
                      decoration: const BoxDecoration(
                        color: Colors.black54,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.lock,
                        color: Color(0xFFFF7A00),
                        size: 10,
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFFF8C00), Color(0xFFFF5E00)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Stack(
            children: [
              Positioned(
                top: -25,
                left: -20,
                child: Container(
                  width: 110,
                  height: 110,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withOpacity(0.12),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),

      // --- NỘI DUNG ---
      body: IndexedStack(index: _selectedIndex, children: _pages),

      // --- THANH ĐIỀU HƯỚNG DƯỚI ---
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          border: Border(top: BorderSide(color: Colors.white10, width: 0.5)),
        ),
        child: BottomNavigationBar(
          backgroundColor: const Color(0xFF121212),
          currentIndex: _selectedIndex,
          onTap: (index) => setState(() => _selectedIndex = index),
          selectedItemColor: const Color(0xFFFF5E00),
          unselectedItemColor: Colors.grey,
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              activeIcon: Icon(Icons.home),
              label: 'Trang chủ',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite_outline),
              activeIcon: Icon(Icons.favorite),
              label: 'Yêu thích',
            ),
          ],
        ),
      ),
    );
  }
}
