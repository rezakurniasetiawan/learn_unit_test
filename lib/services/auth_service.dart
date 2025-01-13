// lib/services/auth_service.dart
import 'package:dio/dio.dart';

abstract class AuthService {
  Future<bool> login(String username, String password);
}

class AuthServiceImpl implements AuthService {
  final Dio dio;

  AuthServiceImpl(this.dio);

  @override
  Future<bool> login(String username, String password) async {
    try {
      final response = await dio.post(
        'https://dummyjson.com/auth/login',
        options: Options(contentType: Headers.jsonContentType),
        data: {
          'username': username,
          'password': password,
        },
      );

      if (response.statusCode == 200) {
        return response.data['success'] as bool;
      } else {
        throw Exception('Login failed');
      }
    } on DioException catch (e) {
      throw Exception('Login error: ${e.message}');
    }
  }
}
