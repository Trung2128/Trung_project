import 'package:duan_thi/api/client.dart'; // Import file DioClient của bạn
import 'package:duan_thi/model/profile_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Auth {
  // Sử dụng chung instance của DioClient thay vì tạo mới
  final _dio = Client().dio;

  Future<String?> login(String username, String password) async {
    try {
      final response = await _dio.post(
        '/auth/login', // Chỉ cần ghi path vì baseUrl đã có trong DioClient
        data: {'username': username, 'password': password, 'expiresInMins': 30},
      );

      if (response.statusCode == 200) {
        final token = response.data['accessToken'];

        // Cập nhật token vào DioClient ngay lập tức để các request sau tự có token
        Client().setToken(token);

        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('accessToken', token);

        return token;
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  Future<Profile?> getProfile() async {
    try {
      // Không cần truyền accessToken vào nữa, DioClient tự lấy từ setToken
      var response = await _dio.get('/auth/me');

      if (response.statusCode == 200) {
        return Profile.fromJson(response.data);
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  Future<bool> isLoggedIn() async {
    final token = await getToken();
    return token != null && token.isNotEmpty;
  }

  Future<void> logout() async {
    Client().clearToken(); // Xóa token trong Dio
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('accessToken');
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('accessToken');
  }
}
