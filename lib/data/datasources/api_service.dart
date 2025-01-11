import 'dart:convert';
import 'package:catalyst_app/data/models/booking_model.dart';
import 'package:catalyst_app/data/models/property_model.dart';
import 'package:catalyst_app/data/models/user_model.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const baseUrl = 'https://test.catalystegy.com/public/api';

  // **User API**
  static Future<List<User>> getUsers() async {
    final response = await http.get(Uri.parse('$baseUrl/users'));

    if (response.statusCode == 200) {
      // Decode the response body as a list of users
      List<dynamic> data = jsonDecode(
          response.body); // This should return a List<Map<String, dynamic>>
      return data
          .map((json) => User.fromJson(json))
          .toList(); // Convert each item to User
    }

    return [];
  }

  static Future<User?> createUser(User newUser) async {
    final response = await http.post(
      Uri.parse('$baseUrl/users'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(newUser.toJson()), // Encoding the User object to JSON
    );
    print("Status code: ${response.statusCode}"); // Log the status code
    print("Response body: ${response.body}"); // Log the response body
    if (response.statusCode == 201) {
      // Decode the response body and map it to User
      var decodedResponse = jsonDecode(response.body);
      return User.fromJson(
          decodedResponse); // Correctly parse the response as a Map
    }

    return null;
  }

  static Future<bool> updateUser(int id, User updatedUser) async {
    final response = await http.post(
      // Changed from PUT to POST
      Uri.parse('$baseUrl/users/$id'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(updatedUser.toJson()),
    );
    print("Status code: ${response.statusCode}"); // Log the status code
    print("Response body: ${response.body}"); // Log the response body

    return response.statusCode ==
        200; // Check if status code is 200 for success
  }

  static Future<bool> deleteUser(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl/users/$id'));
    return response.statusCode == 200;
  }
  ////////////////////////////////////////////////////////////////////////

  // **Property API**
  static Future<List<Map<String, dynamic>>> getProperties() async {
    final response = await http.get(Uri.parse('$baseUrl/properties'));

    if (response.statusCode == 200) {
      print("Response body: ${response.body}");

      // Parse the response as a list of maps
      return List<Map<String, dynamic>>.from(jsonDecode(response.body));
    } else {
      print("Failed to fetch properties. Status code: ${response.statusCode}");
      return [];
    }
  }

  Future<Property?> createProperty(Property newProperty) async {
    final response = await http.post(
      Uri.parse('$baseUrl/properties'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(
          newProperty.toJson()), // Pass the map representation of the property
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      return Property.fromJson(
          data); // Convert the response back into a Property object
    } else {
      return null;
    }
  }

  static Future<bool> updateProperty(
      int id, Map<String, dynamic> updatedProperty) async {
    final response = await http.post(
      Uri.parse('$baseUrl/properties/$id'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(updatedProperty), // Use the map here
    );
    return response.statusCode == 200;
  }

  static Future<bool> deleteProperty(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl/properties/$id'));
    return response.statusCode == 200;
  }
  ////////////////////////////////////////////////////////////////////////////

  // **Booking API**
  static Future<List<Booking>> getBookings() async {
    final response = await http.get(Uri.parse('$baseUrl/bookings'));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);

      // Print the raw JSON data to the console
      print('Response JSON: ${jsonEncode(data)}');

      // Convert JSON to Booking objects
      final bookings = data.map((json) => Booking.fromJson(json)).toList();

      // Print each Booking object in the list
      print('Converted Booking List:');
      bookings.forEach((booking) => print(booking.toString()));

      return bookings;
    } else {
      print('Failed to load bookings. Status code: ${response.statusCode}');
      return [];
    }
  }

  static Future<Booking?> createBooking(Booking newBooking) async {
    final response = await http.post(
      Uri.parse('$baseUrl/bookings'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(newBooking.toJson()),
    );
    if (response.statusCode == 201) {
      return Booking.fromJson(jsonDecode(response.body));
    }
    return null;
  }

  static Future<bool> updateBookingStatus(int id, String status) async {
    final response = await http.post(
      Uri.parse('$baseUrl/bookings/$id/status'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'status': status}),
    );
    return response.statusCode == 200;
  }

  static Future<bool> deleteBooking(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl/bookings/$id'));
    return response.statusCode == 200;
  }
}
