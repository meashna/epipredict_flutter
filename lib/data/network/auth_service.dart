// lib/src/data/network/auth_service.dart
import 'package:dio/dio.dart';
import '../../constants/api_constants.dart';
import 'package:logger/logger.dart';

class AuthService {
  final Dio _dio = Dio();
  final Logger _logger = Logger(); // Logger initialization

  // Login function using Dio
  Future<Map<String, dynamic>?> login(String username, String password) async {
    try {
      _logger.i('Attempting login for user: $username'); // Log login attempt
      final response = await _dio.post(
        ApiConstants.loginEndpoint,
        data: {
          'username': username,
          'password': password,
        },
        options: Options(headers: {'Content-Type': 'application/json'}),
      );

      if (response.statusCode == 200) {
        _logger.i(
            'Login successful, Response received: ${response.data}'); // Log successful response
        return response.data; // Return the response data (token, userId, etc.)
      } else {
        _logger.e('Login failed with status code: ${response.statusCode}');
      }
    } on DioException catch (e) {
      _logger.e('Login error: ${e.message}'); // Log error message
      _logger.e(
          'Error response: ${e.response?.data}'); // Log the API error response
    }
    return null; // Return null if login fails
  }

  // Register function using Dio
  Future<Map<String, dynamic>?> register(
      String username, String password) async {
    try {
      _logger.i(
          'Attempting registration for user: $username'); // Log registration attempt
      final response = await _dio.post(
        ApiConstants.registerEndpoint,
        data: {
          'username': username,
          'password': password,
        },
        options: Options(headers: {'Content-Type': 'application/json'}),
      );

      if (response.statusCode == 201) {
        _logger.i(
            'Registration successful, Response received: ${response.data}'); // Log successful response
        return response.data; // Return response data
      } else {
        _logger
            .e('Registration failed with status code: ${response.statusCode}');
      }
    } on DioException catch (e) {
      _logger.e('Registration error: ${e.message}'); // Log error message
      _logger.e(
          'Error response: ${e.response?.data}'); // Log the API error response
    }
    return null; // Return null if registration fails
  }
}
