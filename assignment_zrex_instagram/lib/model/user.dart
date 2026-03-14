// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class User {
  final String id;
  final String fullName;
  final String username;
  final String email;
  final String password;
  final String profilePicture;
  final String bio;
  final bool isVerifiedIcon;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String token;
  User({
    required this.id,
    required this.fullName,
    required this.username,
    required this.email,
    required this.password,
    this.profilePicture='',
    this.bio='',
    this.isVerifiedIcon = false,
    this.createdAt,
    this.updatedAt,
    required this.token,
  });

  

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'fullName': fullName,
      'username': username,
      'email': email,
      'password': password,
      'profilePicture': profilePicture,
      'bio': bio,
      'isVerifiedIcon': isVerifiedIcon,
      'createdAt': createdAt?.millisecondsSinceEpoch,
      'updatedAt': updatedAt?.millisecondsSinceEpoch,
      'token': token,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['_id'] as String? ?? '',
      fullName: map['fullName'] ?? '',
      username: map['username'] ?? '',
      email: map['email'] ?? '',
      password: map['password'] ?? '',
      profilePicture: map['profilePicture'] ?? '',
      bio: map['bio'] ?? '',
      isVerifiedIcon: map['isVerifiedIcon'] ?? false,
      createdAt: map['createdAt'] != null ? DateTime.parse(map['createdAt']) : null,
      updatedAt: map['updatedAt'] != null ? DateTime.parse(map['updatedAt']) : null,
      token: map['token'] as String? ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source) as Map<String, dynamic>);
}
