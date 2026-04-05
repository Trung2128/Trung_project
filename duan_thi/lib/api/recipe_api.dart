import 'package:dio/dio.dart';
import 'client.dart';

class RecipeApi {
  // Sử dụng Dio đã được cấu hình từ Client
  final _dio = Client().dio;

  /// Lấy danh sách công thức nấu ăn
  Future<List<Map<String, dynamic>>> getRecipes({
    int limit = 20,
    int skip = 0,
  }) async {
    try {
      final response = await _dio.get(
        '/recipes',
        queryParameters: {'limit': limit, 'skip': skip},
      );

      // dummyjson trả về một Map có key là 'recipes'
      final data = response.data;
      if (data != null && data['recipes'] != null) {
        return List<Map<String, dynamic>>.from(data['recipes']);
      }
      return []; // Trả về list rỗng nếu không có dữ liệu
    } on DioException catch (e) {
      // Dùng hàm parseError tĩnh từ class Client của bạn
      throw Exception(Client.parseError(e));
    }
  }

  /// Lấy chi tiết một công thức nấu ăn theo ID
  Future<Map<String, dynamic>> getRecipeById(int id) async {
    try {
      final response = await _dio.get('/recipes/$id');
      return response.data as Map<String, dynamic>;
    } on DioException catch (e) {
      throw Exception(Client.parseError(e));
    }
  }

  /// Tìm kiếm công thức nấu ăn
  Future<List<Map<String, dynamic>>> searchRecipes(String query) async {
    try {
      final response = await _dio.get(
        '/recipes/search',
        queryParameters: {'q': query},
      );
      final data = response.data;
      if (data != null && data['recipes'] != null) {
        return List<Map<String, dynamic>>.from(data['recipes']);
      }
      return [];
    } on DioException catch (e) {
      throw Exception(Client.parseError(e));
    }
  }
}
