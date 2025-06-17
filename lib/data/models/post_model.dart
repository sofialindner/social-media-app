import 'dart:convert';
import 'dart:typed_data';

class Post {
  final int? id;
  final int userId;
  final String? userName;
  final Uint8List? userImage;
  final String? description;
  final List<Uint8List> images;
  final DateTime createdAt;
  bool? liked;

  Post({
    this.id,
    required this.userId,
    this.userName,
    this.userImage,
    this.description,
    required this.images,
    required this.createdAt,
    this.liked = false,
  });

  // Desserialização
  factory Post.fromJson(Map<String, dynamic> json) {
    List<Uint8List>? decodedImages;

    if (json['images'] != null && json['images'] is List) {
      decodedImages = (json['images'] as List)
          .where((img) => img != null && img.toString().isNotEmpty)
          .map<Uint8List>((img) => base64Decode(img))
          .toList();
    }

    return Post(
      id: json['id'],
      userId: json['user_id'] ?? 1,
      userName: json['username'],
      userImage: json['user_image'] != null
          ? base64Decode(json['user_image'])
          : null,
      description: json['description'],
      createdAt: DateTime.parse(json['created_at']),
      images: decodedImages ?? [],
    );
  }

  // Serialização
  Map<String, dynamic> toJson() {
    List<String>? encodedImages;

    if (images.isNotEmpty) {
      encodedImages = images.map<String>((img) => base64Encode(img)).toList();
    }

    return {
      'id': id,
      'user_id': userId,
      'description': description,
      'images': encodedImages,
    };
  }
}
