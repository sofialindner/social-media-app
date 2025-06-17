import 'dart:convert';
import 'dart:typed_data';

class User {
  final int? id;
  final String? name;
  final String? email;
  final String? password;
  final Uint8List? image;
  final int? postCount;
  final int? followersCount;
  final int? followingCount;
  final bool? follows;

  User({
    this.id,
    this.name,
    required this.email,
    this.password,
    this.image,
    this.postCount,
    this.followersCount,
    this.followingCount,
    this.follows,
  });

  // Desserialização
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      password: json['password'],
      image: json['image'] != null ? base64Decode(json['image']) : null,
      postCount: json['postCount'],
      followersCount: json['followers'],
      followingCount: json['following'],
      follows: json['follows'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};

    if (id != null) data['id'] = id;
    if (name != null && name!.isNotEmpty) data['name'] = name;
    if (email != null && email!.isNotEmpty) data['email'] = email;
    if (password != null && password!.isNotEmpty) data['password'] = password;

    return data;
  }
}
