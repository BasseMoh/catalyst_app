import 'package:catalyst_app/data/models/property_model.dart';
import 'package:catalyst_app/data/models/user_model.dart';

class Booking {
  final int id;
  final int userId;
  final int propertyId;
  final String startDate;
  final String endDate;
  String status;
  final String createdAt;
  final String updatedAt;
  final User user;
  final Property property;

  Booking({
    required this.id,
    required this.userId,
    required this.propertyId,
    required this.startDate,
    required this.endDate,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.user,
    required this.property,
  });

  // Factory method to create a Booking from JSON
  factory Booking.fromJson(Map<String, dynamic> json) {
    return Booking(
      id: json['id'] ?? 0,
      userId: json['user_id'] ?? 0,
      propertyId: json['property_id'] ?? 0,
      startDate: json['start_date'] ?? '',
      endDate: json['end_date'] ?? '',
      status: json['status'] ?? '',
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
      user: User.fromJson(json['user'] ?? {}),
      property: Property.fromJson(json['property'] ?? {}),
    );
  }

  // Method to convert a Booking object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'property_id': propertyId,
      'start_date': startDate,
      'end_date': endDate,
      'status': status,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'user': user.toJson(),
      'property': property.toJson(),
    };
  }
}