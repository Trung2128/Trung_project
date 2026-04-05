import 'package:dio/dio.dart';

class Client { // Giữ tên này để các file Auth, Login không bị báo lỗi đỏ
  static final Client _instance = Client._internal();
  factory Client() => _instance;

  late final Dio dio;
  String? _token;

  Client._internal() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://dummyjson.com',
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        contentType: 'application/json',
        responseType: ResponseType.json,
      ),
    );

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          if (_token != null) {
            options.headers['Authorization'] = 'Bearer $_token';
          }
          // Log đúng ý bạn
          print('[Dio hoạt động] ${options.method} ${options.path}');
          return handler.next(options);
        },
        onResponse: (response, handler) {
          // Log đúng ý bạn
          print('[Dio hoạt động] ${response.statusCode} ${response.requestOptions.path}');
          return handler.next(response);
        },
        onError: (DioException e, handler) {
          // Log đúng ý bạn
          print('[Lỗi Dio] ${e.response?.statusCode} ${e.requestOptions.path}');
          return handler.next(e);
        },
      ),
    );
  }

  void setToken(String token) => _token = token;
  void clearToken() => _token = null;

  static String parseError(DioException e) {
    try {
      final data = e.response?.data;
      if (data is Map && data['message'] != null) {
        return data['message'].toString();
      }
    } catch (_) {}
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
        return 'Kết nối quá thời gian, vui lòng thử lại.';
      case DioExceptionType.connectionError:
        return 'Không có kết nối mạng.';
      default:
        return e.message ?? 'Đã có lỗi xảy ra.';
    }
  }
}