import 'package:catalyst_app/data/datasources/api_service.dart';
import 'package:catalyst_app/data/models/booking_model.dart';
import 'package:get/get.dart';

class BookingController extends GetxController {
  var bookings = <Booking>[].obs; // Observable bookings
  var filteredBookings = <Booking>[].obs; // Observable list for filtered bookings
  var isLoading = false.obs; // Loading state
  var searchQuery = ''.obs; // Search query for filtering bookings

  @override
  void onInit() {
    super.onInit();
    fetchBookings(); // Fetch bookings on initialization
    ever(searchQuery, (_) => filterBookings()); // Filter bookings on searchQuery changes
  }

  // Fetch bookings from API
  Future<void> fetchBookings() async {
    isLoading.value = true;
    try {
      final fetchedBookings = await ApiService.getBookings();
      if (fetchedBookings != null && fetchedBookings.isNotEmpty) {
        bookings.assignAll(fetchedBookings);
        filterBookings(); // Apply search filter after fetching data
      } else {
        bookings.clear(); // Clear bookings if none are found
        filteredBookings.clear();
        print("No bookings found.");
      }
    } catch (e) {
      print("Error fetching bookings: $e");
    } finally {
      isLoading.value = false;
    }
  }

  // Filter bookings based on search query
  void filterBookings() {
    if (searchQuery.value.isEmpty) {
      filteredBookings.assignAll(bookings);
    } else {
      filteredBookings.assignAll(
        bookings.where((booking) =>
            booking.status.toLowerCase().contains(searchQuery.value.toLowerCase()) ||
            booking.id.toString().contains(searchQuery.value)).toList(),
      );
    }
  }

  // Create a new booking and add it to the list
  Future<void> createBooking(Booking newBooking) async {
    try {
      final createdBooking = await ApiService.createBooking(newBooking);
      if (createdBooking != null) {
        bookings.insert(0, createdBooking); // Add the new booking at the top of the list
        filterBookings(); // Reapply the search filter
      }
    } catch (e) {
      print("Error creating booking: $e");
    }
  }

// Update the status of a booking
Future<void> updateBookingStatus(int bookingId, String newStatus) async {
  try {
    // Find the booking by ID
    final bookingIndex = bookings.indexWhere((b) => b.id == bookingId);
    if (bookingIndex != -1) {
      // Update the status of the booking
      bookings[bookingIndex].status = newStatus;

      // Inform GetX that the list has changed
      bookings.refresh();  // This will notify listeners

      // You can also call the filterBookings if needed
      filterBookings();  // Assuming this is responsible for updating filtered bookings
    } else {
      print("Booking with ID $bookingId not found.");
    }
  } catch (e) {
    print("Error updating booking status: $e");
  }
}
  // Delete a booking
  Future<void> deleteBooking(int id) async {
    try {
      final isDeleted = await ApiService.deleteBooking(id);
      if (isDeleted) {
        bookings.removeWhere((booking) => booking.id == id);
        bookings.refresh();
        filterBookings();
      }
    } catch (e) {
      print("Error deleting booking: $e");
    }
  }
}
