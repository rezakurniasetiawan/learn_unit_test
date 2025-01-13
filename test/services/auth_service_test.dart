// test/services/auth_service_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:learn_unit_test/services/auth_service.dart';
import 'package:mockito/mockito.dart';
import 'package:dio/dio.dart';

import '../mocks/auth_service_test.mocks.dart';

void main() {
  late MockDio mockDio;
  late AuthService authService;

  setUp(() {
    mockDio = MockDio();
    authService = AuthServiceImpl(mockDio);
  });

  test('should return true when login is successful', () async {
    // Arrange
    const username = 'emilys';
    const password = 'emilyspass';
    String url = 'https://dummyjson.com/auth/login';
    when(mockDio.post(
      url,
      data: {'username': username, 'password': password},
      queryParameters: null,
      options: anyNamed('options'),
      cancelToken: null,
      onSendProgress: null,
      onReceiveProgress: null,
    )).thenAnswer(
      (_) async => Response(
        data: {
          "success": true,
          "accessToken":
              "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwidXNlcm5hbWUiOiJlbWlseXMiLCJlbWFpbCI6ImVtaWx5LmpvaG5zb25AeC5kdW1teWpzb24uY29tIiwiZmlyc3ROYW1lIjoiRW1pbHkiLCJsYXN0TmFtZSI6IkpvaG5zb24iLCJnZW5kZXIiOiJmZW1hbGUiLCJpbWFnZSI6Imh0dHBzOi8vZHVtbXlqc29uLmNvbS9pY29uL2VtaWx5cy8xMjgiLCJpYXQiOjE3MzY3Mzg0MjMsImV4cCI6MTczNjc0MDIyM30.MHAXEAiYvh1uQ4fS3OF_maytFCtxHbStVQq2O2RXrFM",
          "refreshToken":
              "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwidXNlcm5hbWUiOiJlbWlseXMiLCJlbWFpbCI6ImVtaWx5LmpvaG5zb25AeC5kdW1teWpzb24uY29tIiwiZmlyc3ROYW1lIjoiRW1pbHkiLCJsYXN0TmFtZSI6IkpvaG5zb24iLCJnZW5kZXIiOiJmZW1hbGUiLCJpbWFnZSI6Imh0dHBzOi8vZHVtbXlqc29uLmNvbS9pY29uL2VtaWx5cy8xMjgiLCJpYXQiOjE3MzY3Mzg0MjMsImV4cCI6MTczOTMzMDQyM30.bWNy8RmqhrErgqfvSQMTRqjx8A1WWJxhZJ8gnQiKlaU",
          "id": 1,
          "username": "emilys",
          "email": "emily.johnson@x.dummyjson.com",
          "firstName": "Emily",
          "lastName": "Johnson",
          "gender": "female",
          "image": "https://dummyjson.com/icon/emilys/128"
        },
        statusCode: 200,
        requestOptions: RequestOptions(path: url),
      ),
    );

    // Act
    final result = await authService.login(username, password);

    // Assert
    expect(result, true);
    verify(mockDio.post(
      url,
      data: {'username': username, 'password': password},
      queryParameters: null,
      options: anyNamed('options'),
      cancelToken: null,
      onSendProgress: null,
      onReceiveProgress: null,
    )).called(1);
  });

  test('should throw exception when login fails', () async {
    String url = 'https://dummyjson.com/auth/login';
    // Arrange
    const username = 'wronguser';
    const password = 'wrongpassword';
    when(mockDio.post(
      url,
      data: {'username': username, 'password': password},
      queryParameters: null,
      options: anyNamed('options'),
      cancelToken: null,
      onSendProgress: null,
      onReceiveProgress: null,
    )).thenAnswer(
      (_) async => Response(
        data: {'message': 'Access Token is required'},
        statusCode: 401,
        requestOptions: RequestOptions(path: ''),
      ),
    );

    // Act & Assert
    expect(() => authService.login(username, password), throwsException);
    verify(mockDio.post(
      url,
      data: {'username': username, 'password': password},
      queryParameters: null,
      options: anyNamed('options'),
      cancelToken: null,
      onSendProgress: null,
      onReceiveProgress: null,
    )).called(1);
  });
}
  