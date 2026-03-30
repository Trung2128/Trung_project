import 'package:flutter/material.dart';
import 'package:my_project/services/auth_service.dart';
import 'package:my_project/models/my_individual.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();
  final Color primaryColor = const Color(0xFF0CB39F);

  final usernameCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();
  final confirmCtrl = TextEditingController();

  // Chỉ dùng 1 biến duy nhất để ẩn/hiện mật khẩu cho cả 2 ô
  bool isHidden = true;
  bool _isLoading = false;

  @override
  void dispose() {
    usernameCtrl.dispose();
    emailCtrl.dispose();
    passwordCtrl.dispose();
    confirmCtrl.dispose();
    super.dispose();
  }

  void handleRegister() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);

    try {
      bool isSuccess = await LoginService.register(
        emailCtrl.text.trim(),
        passwordCtrl.text.trim(),
        usernameCtrl.text.trim(),
      );

      if (!mounted) return;

      if (isSuccess) {
        UserData.name = usernameCtrl.text.trim();
        _showSnackBar("Tạo tài khoản thành công!", primaryColor);
        Future.delayed(
          const Duration(seconds: 1),
          () => Navigator.pop(context),
        );
      } else {
        _showSnackBar("Đăng ký thất bại!", Colors.redAccent);
      }
    } catch (e) {
      _showSnackBar("Lỗi kết nối!", Colors.redAccent);
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF148F77), Color(0xFF0CB39F), Colors.white],
          ),
        ),
        child: Column(
          children: [
            _buildBackButton(),
            Expanded(
              child: Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        const Icon(
                          Icons.person_add_alt_1,
                          size: 70,
                          color: Colors.white,
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          "TẠO TÀI KHOẢN",
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.w900,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 30),

                        _buildTextField(
                          controller: usernameCtrl,
                          label: "Tên hiển thị",
                          icon: Icons.person_outline,
                        ),
                        const SizedBox(height: 15),

                        _buildTextField(
                          controller: emailCtrl,
                          label: "Email",
                          icon: Icons.email_outlined,
                          validator: (v) => (v != null && v.contains("@"))
                              ? null
                              : "Email không hợp lệ",
                        ),
                        const SizedBox(height: 15),

                        // Ô Mật khẩu
                        _buildTextField(
                          controller: passwordCtrl,
                          label: "Mật khẩu",
                          icon: Icons.lock_outline,
                          isPassword: true,
                          onToggle: () => setState(() => isHidden = !isHidden),
                        ),
                        const SizedBox(height: 15),

                        // Ô Xác nhận mật khẩu (Dùng chung biến isHidden)
                        _buildTextField(
                          controller: confirmCtrl,
                          label: "Xác nhận mật khẩu",
                          icon: Icons.lock_reset,
                          isPassword: true,
                          onToggle: () => setState(() => isHidden = !isHidden),
                          validator: (v) => v == passwordCtrl.text
                              ? null
                              : "Mật khẩu không khớp",
                        ),

                        const SizedBox(height: 40),
                        _buildRegisterButton(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- Helper Widgets ---

  Widget _buildBackButton() {
    return SafeArea(
      child: Align(
        alignment: Alignment.centerLeft,
        child: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.white,
            size: 20,
          ),
        ),
      ),
    );
  }

  Widget _buildRegisterButton() {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton(
        onPressed: _isLoading ? null : handleRegister,
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        child: _isLoading
            ? const CircularProgressIndicator(color: Colors.white)
            : const Text(
                "ĐĂNG KÝ NGAY",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    bool isPassword = false,
    VoidCallback? onToggle,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: isPassword ? isHidden : false,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: primaryColor),
        suffixIcon: isPassword
            ? IconButton(
                icon: Icon(isHidden ? Icons.visibility_off : Icons.visibility),
                onPressed: onToggle,
              )
            : null,
        filled: true,
        fillColor: Colors.white.withOpacity(0.9),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
      ),
      validator:
          validator ?? (v) => (v == null || v.isEmpty) ? "Bắt buộc" : null,
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
