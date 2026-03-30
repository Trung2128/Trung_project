import 'package:flutter/material.dart';
import 'package:my_project/screens/home/my_home.dart';
import 'package:my_project/screens/home/my_library.dart';
import 'package:my_project/screens/profile/my_profile.dart';
import 'package:my_project/screens/home/my_drawer.dart';
import 'package:my_project/models/my_individual.dart';

class WrapperScreen extends StatefulWidget {
  const WrapperScreen({super.key});

  @override
  State<WrapperScreen> createState() => _WrapperScreenState();
}

class _WrapperScreenState extends State<WrapperScreen> {
  int _selectedIndex = 0;

  // Màu chủ đạo của ứng dụng
  static const Color primaryColor = Color(0xFF0CB39F);

  // Hàm xử lý khi nhấn vào BottomNavigationBar
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Khởi tạo lại danh sách trang trong build để cập nhật dữ liệu mới nhất (isFav, status, v.v.)
    final List<Widget> pages = [
      const HomeScreen(),
      const LibraryScreen(),
    ];

    return Scaffold(
      drawer: const MyDrawer(),
      appBar: AppBar(
        elevation: 2,
        backgroundColor: primaryColor,
        iconTheme: const IconThemeData(color: Colors.white),
        title: _buildAppBarTitle(context),
      ),
      
      // IndexedStack giúp giữ lại vị trí cuộn trang nhưng vẫn nhận children mới khi build lại
      body: IndexedStack(
        index: _selectedIndex,
        children: pages,
      ),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: primaryColor,
        unselectedItemColor: Colors.grey,
        selectedFontSize: 12,
        unselectedFontSize: 12,
        showUnselectedLabels: true,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home_rounded),
            label: 'Trang chủ',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.library_books_outlined),
            activeIcon: Icon(Icons.library_books_rounded),
            label: 'Thư viện',
          ),
        ],
      ),
    );
  }

  // Tách riêng Widget Title của AppBar để code gọn gàng hơn
  Widget _buildAppBarTitle(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Sách Hay',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        GestureDetector(
          onTap: () async {
            // Đợi kết quả từ ProfileScreen trả về
            await Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ProfileScreen()),
            );
            // Sau khi quay lại, cập nhật lại UI để hiển thị Avatar mới (nếu có đổi)
            if (mounted) setState(() {});
          },
          child: _buildUserAvatar(),
        ),
      ],
    );
  }

  // Widget hiển thị ảnh đại diện
  Widget _buildUserAvatar() {
    return CircleAvatar(
      radius: 19,
      backgroundColor: Colors.white.withOpacity(0.5),
      child: CircleAvatar(
        radius: 17,
        backgroundColor: Colors.grey.shade200,
        backgroundImage: UserData.image.isNotEmpty 
            ? NetworkImage(UserData.image) 
            : null,
        onBackgroundImageError: (_, __) {
          // Xử lý khi link ảnh lỗi
        },
        child: UserData.image.isEmpty
            ? const Icon(Icons.person, color: primaryColor, size: 20)
            : null,
      ),
    );
  }
}