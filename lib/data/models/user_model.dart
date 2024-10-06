// lib/src/data/models/user_model.dart
class User {
  final String token;
  final String userId;

  User({required this.token, required this.userId});

  // Factory constructor to create a User instance from JSON
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      token: json['token'],
      userId: json['userId'],
    );
  }

  // Convert User instance to JSON for sending data
  Map<String, dynamic> toJson() {
    return {
      'token': token,
      'userId': userId,
    };
  }
}
