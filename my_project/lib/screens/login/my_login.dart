import 'package:flutter/material.dart';
import 'package:my_project/screens/home/my_wrapper.dart';
import 'my_register.dart';
import 'package:my_project/services/auth_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final userCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();
  final Color primaryColor = const Color(0xFF0CB39F);

  bool isLoading = false;
  bool isHidden = true;

  @override
  void dispose() {
    userCtrl.dispose();
    passwordCtrl.dispose();
    super.dispose();
  }

  void handleLogin() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => isLoading = true);

    try {
      // Gọi đến Service kết nối DummyJSON
      bool success = await LoginService.login(
        userCtrl.text.trim(),
        passwordCtrl.text.trim(),
      );

      if (!mounted) return;

      if (success) {
        _showSnackBar("Chào mừng bạn quay trở lại!", primaryColor);

        // --- THAY ĐỔI Ở ĐÂY: Chuyển qua Splash Screen để nạp dữ liệu sách ---
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const WrapperScreen()),
        );
      } else {
        _showSnackBar(
          "Tài khoản hoặc mật khẩu không chính xác",
          Colors.redAccent,
        );
      }
    } catch (e) {
      _showSnackBar("Lỗi kết nối API!", Colors.redAccent);
    } finally {
      if (mounted) setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [const Color(0xFF148F77), primaryColor, Colors.white],
            ),
          ),
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    _buildHeader(),
                    const SizedBox(height: 50),
                    _buildTextField(
                      controller: userCtrl,
                      label: "Tài khoản",
                      hint: "Nhập username (ví dụ: emilys)",
                      icon: Icons.person_outline,
                      enabled: !isLoading,
                      textInputAction:
                          TextInputAction.next, // Nhấn nút Next trên bàn phím
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Vui lòng nhập tài khoản';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    _buildTextField(
                      controller: passwordCtrl,
                      label: "Mật khẩu",
                      hint: "Nhập mật khẩu (ví dụ: emilyspass)",
                      icon: Icons.lock_outline,
                      isPassword: true,
                      enabled: !isLoading,
                      textInputAction:
                          TextInputAction.done, // Nhấn nút Done trên bàn phím
                      onFieldSubmitted:
                          handleLogin, // Nhấn Done là gọi login luôn
                    ),
                    const SizedBox(height: 40),
                    Row(
                      children: [
                        Expanded(child: _buildLoginButton()),
                        const SizedBox(width: 15),
                        Expanded(child: _buildRegisterButton()),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return const Column(
      children: [
        Icon(Icons.auto_stories, size: 80, color: Colors.white),
        SizedBox(height: 10),
        Text(
          "SÁCH HAY",
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.w900,
            color: Colors.white,
            letterSpacing: 2,
          ),
        ),
        Text(
          "Tri thức là sức mạnh",
          style: TextStyle(color: Colors.white70, fontSize: 16),
        ),
      ],
    );
  }

  Widget _buildLoginButton() {
    return SizedBox(
      height: 55,
      child: ElevatedButton(
        onPressed: isLoading ? null : handleLogin,
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        child: isLoading
            ? const SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2,
                ),
              )
            : const Text(
                "ĐĂNG NHẬP",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
      ),
    );
  }

  Widget _buildRegisterButton() {
    return OutlinedButton(
      onPressed: isLoading
          ? null
          : () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const Register()),
            ),
      style: OutlinedButton.styleFrom(
        side: BorderSide(color: primaryColor, width: 2),
        minimumSize: const Size(0, 55),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      ),
      child: Text(
        "ĐĂNG KÝ",
        style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    bool isPassword = false,
    bool enabled = true,
    TextInputAction? textInputAction,
    VoidCallback? onFieldSubmitted,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      enabled: enabled,
      obscureText: isPassword ? isHidden : false,
      textInputAction: textInputAction,
      onFieldSubmitted: (_) => onFieldSubmitted?.call(),
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: Icon(icon, color: primaryColor),
        suffixIcon: isPassword
            ? IconButton(
                icon: Icon(
                  isHidden ? Icons.visibility_off : Icons.visibility,
                  color: Colors.grey,
                ),
                onPressed: enabled
                    ? () => setState(() => isHidden = !isHidden)
                    : null,
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
          validator ??
          (value) =>
              (value == null || value.isEmpty) ? 'Không được để trống' : null,
    );
  }

  void _showSnackBar(String message, Color bgColor) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
        backgroundColor: bgColor,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(15),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}
