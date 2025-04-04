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
    try {
      return User(
        username: json['username'],
        email: json['email'],
        createdAt: DateTime.parse(json['createdAt']),
      );
    } catch (e) {
      throw FormatException('Failed to parse user json: $e');
    }
  }
}