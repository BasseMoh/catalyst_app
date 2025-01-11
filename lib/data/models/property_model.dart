import 'dart:convert';

class Property {
  final int id;
  final int userId;
  final String name;
  final String description;
  final String price;
  final String location;
  final List<String> images;
  final String video;
  final String createdAt;
  final String updatedAt;

  Property({
    required this.id,
    required this.userId,
    required this.name,
    required this.description,
    required this.price,
    required this.location,
    required this.images,
    required this.video,
    required this.createdAt,
    required this.updatedAt,
  });

  // Factory method to create a Property from JSON
  factory Property.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      throw ArgumentError('Invalid JSON: null');
    }

    return Property(
      id: json['id'] is int ? json['id'] : int.tryParse(json['id']?.toString() ?? '0') ?? 0,
      userId: json['user_id'] is int ? json['user_id'] : int.tryParse(json['user_id']?.toString() ?? '0') ?? 0,
      name: json['name']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      price: json['price']?.toString() ?? '',
      location: json['location']?.toString() ?? '',
      images: _parseImages(json['images']),
      video: json['video']?.toString() ?? '',
      createdAt: json['created_at']?.toString() ?? '',
      updatedAt: json['updated_at']?.toString() ?? '',
    );
  }

  // Method to convert a Property object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'name': name,
      'description': description,
      'price': price,
      'location': location,
      'images': jsonEncode(images), // Encode the list as a JSON string
      'video': video,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }

  // Helper method to parse images field
  static List<String> _parseImages(dynamic images) {
    if (images == null) {
      return [];
    }
    if (images is String) {
      try {
        return List<String>.from(jsonDecode(images));
      } catch (_) {
        return [images]; // Treat it as a single image string if decoding fails
      }
    }
    if (images is List) {
      return images.cast<String>();
    }
    return [];
  }

  // Helper method to transform local image paths to full URLs
  static List<String> resolveImagePaths(List<String> imagePaths, String baseUrl) {
    return imagePaths.map((path) {
      // Ensure the path has the correct formatting and prepend the base URL
      return baseUrl + path.replaceAll(r'\\', '/'); // Replace escaped slashes
    }).toList();
  }
}
