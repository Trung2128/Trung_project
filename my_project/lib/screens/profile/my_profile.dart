import 'package:flutter/material.dart';
import 'package:my_project/screens/profile/my_notification.dart';
import 'package:my_project/screens/profile/my_help.dart';
import 'package:my_project/screens/profile/my_edit_profile.dart';
import 'package:my_project/models/my_individual.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final Color primaryColor = const Color(0xFF0CB39F);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F7),
      appBar: AppBar(
        title: const Text(
          'Hồ sơ của tôi',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: primaryColor,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: const BorderRadius.vertical(
                  bottom: Radius.circular(30),
                ),
              ),
              padding: const EdgeInsets.only(bottom: 40, top: 10),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 52,
                    backgroundColor: Colors.white,
                    child: CircleAvatar(
                      radius: 48,
                      backgroundImage: NetworkImage(
                        UserData.image,
                      ), // Sửa lại đúng tên biến profileImage
                    ),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    UserData.name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    UserData.bio,
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ), // Thêm const vì style cố định
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              child: Card(
                elevation: 1,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  children: [
                    _buildListTile(
                      Icons.person_outline,
                      'Chỉnh sửa hồ sơ',
                      Colors.blue,
                      onTap: () =>
                          _navigateTo(const EditProfileScreen(), update: true),
                    ),
                    const Divider(height: 1, indent: 60),

                    _buildListTile(
                      Icons.notifications_none,
                      'Thông báo',
                      Colors.orange,
                      onTap: () => _navigateTo(const NotificationScreen()),
                    ),
                    const Divider(height: 1, indent: 60),

                    _buildListTile(
                      Icons.help_outline,
                      'Trợ giúp',
                      Colors.purple,
                      onTap: () => _navigateTo(const HelpScreen()),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Hàm điều hướng gom gọn lại
  void _navigateTo(Widget screen, {bool update = false}) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => screen),
    ).then((_) {
      if (update && mounted) setState(() {});
    });
  }

  Widget _buildListTile(
    IconData icon,
    String title,
    Color color, {
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: color),
      ),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
      trailing: const Icon(
        Icons.arrow_forward_ios,
        size: 14,
        color: Colors.grey,
      ),
      onTap: onTap,
    );
  }
}
