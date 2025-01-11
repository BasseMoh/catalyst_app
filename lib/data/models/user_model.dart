class User {
  final int id;
  final String name;
  final String email;
  final String phone;
  final String role;
  final String profileImage;
  final String introVideo;
  final String createdAt;
  final String updatedAt;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.role,
    required this.profileImage,
    required this.introVideo,
    required this.createdAt,
    required this.updatedAt,
  });

  // Ensure this method is correct
factory User.fromJson(Map<String, dynamic> json) {
  return User(
    id: json['id'] ?? 0,  // Default to 0 if id is null
    name: json['name'] ?? '',  // Default to empty string if name is null
    email: json['email'] ?? '',  // Default to empty string if email is null
    phone: json['phone'] ?? '',  // Default to empty string if phone is null
    role: json['role'] ?? '',  // Default to empty string if role is null
    profileImage: json['profile_image'] ?? '',  // Default to empty string if profile_image is null
    introVideo: json['intro_video'] ?? '',  // Default to empty string if intro_video is null
    createdAt: json['created_at'] ?? '',  // Default to empty string if created_at is null
    updatedAt: json['updated_at'] ?? '',  // Default to empty string if updated_at is null
  );
}

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'role': role,
      'profile_image': profileImage,
      'intro_video': introVideo,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}
