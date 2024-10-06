import '../models/user_model.dart';
import '../network/auth_service.dart';

class AuthRepository {
  final AuthService _authService = AuthService();

  // Handles login logic by sending username/password and receiving token + userId
  Future<User?> login(String username, String password) async {
    final response = await _authService.login(username, password);

    if (response != null &&
        response.containsKey('token') &&
        response.containsKey('userId')) {
      return User.fromJson(
          response); // Convert response (token + userId) to User model
    }
    return null;
  }

  // Handles registration logic (expect userId in the response)
  Future<bool> register(String username, String password) async {
    final response = await _authService.register(username, password);

    if (response != null && response.containsKey('userId')) {
      return true; // Registration successful
    }
    return false; // Registration failed
  }
}
