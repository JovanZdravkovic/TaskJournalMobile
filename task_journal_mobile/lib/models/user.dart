import 'dart:core';

class User {
  final String username;
  final String email;
  final DateTime createdAt;

  User({ 
    required this.username,
    required this.email,
    required this.createdAt
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'username': String username,
        'email': String email,
        'createdAt': DateTime createdAt,
      } =>
        User(
          username: username,
          email: email,
          createdAt: createdAt,
        ),
      _ => throw const FormatException('Failed to parse user json.'),
    };
  }
}