import 'package:flutter/material.dart';
import 'package:my_project/models/my_individual.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final Color primaryColor = const Color(0xFF0CB39F);
  late TextEditingController _nameController;
  late TextEditingController _bioController;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: UserData.name);
    _bioController = TextEditingController(text: UserData.bio);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  Future<void> _handleSave() async {
    if (_nameController.text.trim().isEmpty) {
      _showSnackBar('Tên không được để trống!', Colors.orange);
      return;
    }

    setState(() => _isLoading = true);
    await Future.delayed(const Duration(milliseconds: 600));

    UserData.name = _nameController.text.trim();
    UserData.bio = _bioController.text.trim();

    if (mounted) {
      _showSnackBar('Cập nhật thành công!', primaryColor);
      Navigator.pop(context, true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Chỉnh sửa hồ sơ',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: primaryColor,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          _isLoading
              ? const Padding(
                  padding: EdgeInsets.only(right: 15),
                  child: Center(
                    child: SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      ),
                    ),
                  ),
                )
              : TextButton(
                  onPressed: _handleSave,
                  child: const Text(
                    'LƯU',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(25),
        child: Column(
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(
                UserData.image,
              ), // Đã sửa tên biến
            ),
            const SizedBox(height: 30),

            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Họ và tên',
                prefixIcon: Icon(Icons.person_outline, color: primaryColor),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 20),

            TextField(
              controller: _bioController,
              maxLines: 4,
              maxLength: 150,
              decoration: InputDecoration(
                labelText: 'Tiểu sử (Bio)',
                hintText: 'Chia sẻ đôi chút về bản thân...',
                alignLabelWithHint: true,
                prefixIcon: Icon(
                  Icons.edit_note,
                  color: primaryColor,
                ), // Flutter sẽ tự căn giữa icon này theo box
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: primaryColor, width: 2),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showSnackBar(String message, Color bgColor) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: bgColor,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
