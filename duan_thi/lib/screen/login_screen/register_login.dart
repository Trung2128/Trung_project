import 'package:flutter/material.dart';
import 'package:duan_thi/api/auth.dart';
import 'package:duan_thi/screen/login_screen/login.dart';

class RequireLogin extends StatefulWidget {
  const RequireLogin({super.key});

  static void showLoginDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          backgroundColor: const Color(
            0xFF1A1A1A,
          ), // Đồng bộ màu với Form Login của bạn
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20), // Bo tròn hơn cho hiện đại
            side: BorderSide(color: Colors.white.withOpacity(0.1)), // Viền nhẹ
          ),
          title: const Text(
            'Yêu cầu đăng nhập',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.lock_person_rounded,
                color: Color(0xFFFF5E00),
                size: 50,
              ),
              const SizedBox(height: 15),
              const Text(
                'Vui lòng đăng nhập để sử dụng đầy đủ các tính năng hấp dẫn của ứng dụng.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white70, fontSize: 14),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('Để sau', style: TextStyle(color: Colors.grey)),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(dialogContext);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const LoginScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFF5E00),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                'Đăng nhập',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  State<RequireLogin> createState() => _RequireLoginLabelState();
}

class _RequireLoginLabelState extends State<RequireLogin> {
  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  void _checkLoginStatus() async {
    // Lưu ý: Đảm bảo class Auth() của bạn có hàm isLoggedIn() trả về Future<bool>
    bool loggedIn = await Auth().isLoggedIn();
    if (!mounted) return;

    if (!loggedIn) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        RequireLogin.showLoginDialog(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink();
  }
}
