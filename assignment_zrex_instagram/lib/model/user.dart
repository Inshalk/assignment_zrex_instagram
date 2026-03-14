import 'dart:convert';

class User {
  final String fullName;
  final String username;
  final String email;
  final String password;
  final String profilePicture;
  final String bio;
  final bool isVerifiedIcon;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  User({
    required this.fullName,
    required this.username,
    required this.email,
    required this.password,
    this.profilePicture = "",
    this.bio = "",
    this.isVerifiedIcon = false,
    this.createdAt,
    this.updatedAt,
  });

  // Convert Map (JSON) to User Object
  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      fullName: map['fullName'] ?? '',
      username: map['username'] ?? '',
      email: map['email'] ?? '',
      password: map['password'] ?? '',
      profilePicture: map['profilePicture'] ?? '',
      bio: map['bio'] ?? '',
      isVerifiedIcon: map['isVerifiedIcon'] ?? false,
      createdAt: map['createdAt'] != null ? DateTime.parse(map['createdAt']) : null,
      updatedAt: map['updatedAt'] != null ? DateTime.parse(map['updatedAt']) : null,
    );
  }

  // Convert User Object to Map (JSON)
  Map<String, dynamic> toMap() {
    return {
      'fullName': fullName,
      'username': username,
      'email': email,
      'password': password,
      'profilePicture': profilePicture,
      'bio': bio,
      'isVerifiedIcon': isVerifiedIcon,
      
    };
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));
}