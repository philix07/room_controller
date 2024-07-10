// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class AppUser {
  final String id;
  final String email;
  final String username;
  final UserRole role;
  final DateTime createdAt;

  AppUser({
    required this.id,
    required this.email,
    required this.username,
    required this.role,
    required this.createdAt,
  });

  factory AppUser.dummy() {
    return AppUser(
      id: 'dummy',
      email: 'abcd@gmail.com',
      username: 'anonymous',
      role: UserRole.none,
      createdAt: DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'email': email,
      'username': username,
      'role': role.value,
      'createdAt': createdAt.toString(),
    };
  }

  factory AppUser.fromMap(Map<String, dynamic> map) {
    return AppUser(
      id: map['id'] as String,
      email: map['email'] as String,
      username: map['username'] as String,
      role: UserRole.fromString(map['role'] as String),
      createdAt: DateTime.parse(map['createdAt'] as String),
    );
  }

  String toJson() => json.encode(toMap());

  factory AppUser.fromJson(String source) =>
      AppUser.fromMap(json.decode(source) as Map<String, dynamic>);
}

enum UserRole {
  none('None'),
  user('User'),
  admin('Admin');

  final String value;
  const UserRole(this.value);

  static UserRole fromString(String role) {
    switch (role) {
      case 'User':
        return UserRole.user;
      case 'Admin':
        return UserRole.admin;
      default:
        return UserRole.none;
    }
  }
}
