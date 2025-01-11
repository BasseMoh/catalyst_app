import 'package:catalyst_app/core/utils/screen_size.dart';
import 'package:catalyst_app/data/models/property_model.dart';
import 'package:catalyst_app/data/models/user_model.dart';
import 'package:catalyst_app/presentation/controllers/booking_controller.dart';
import 'package:catalyst_app/presentation/pages/bookings/add_booking_dialog.dart';
import 'package:catalyst_app/presentation/pages/bookings/booking_details_screen.dart';
import 'package:catalyst_app/presentation/pages/bookings/update_status_dialog.dart';
import 'package:catalyst_app/presentation/widgets/custom_delete_dialog.dart';
import 'package:catalyst_app/presentation/widgets/custom_search_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BookingsScreen extends StatelessWidget {
  final BookingController bookingController = Get.put(BookingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bookings'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              showDialog(
                context: context,
                builder: (_) {
                  return AddBookingDialog(
                    onSave: ({
                      required int bookingId,
                      required String status,
                      required String startDate,
                      required String endDate,
                    }) {
                      // Assuming you have `user` and `property` objects available
                      final User user; 
                      final Property property;

                      // Create a new booking
                      // bookingController.createBooking(
                      //   Booking(
                      //     id: bookingId,
                      //     userId: user.id, 
                      //     propertyId: property.id,
                      //     startDate: startDate,
                      //     endDate: endDate,
                      //     status: status,
                      //     createdAt: DateTime.now().toString(), 
                      //     updatedAt: DateTime.now().toString(), 
                      //     user: user, 
                      //     property: property, 
                      //   ),
                      // );

                      bookingController
                          .fetchBookings(); // Refresh the booking list
                    },
                  );
                },
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          CustomSearchTextField(
            labelText: 'Search by ID or Status',
            onChanged: (query) => bookingController.searchQuery.value = query,
          ),
          Expanded(
            child: Obx(() {
              if (bookingController.isLoading.value) {
                // Show loading spinner while data is being fetched
                return Center(child: CircularProgressIndicator());
              }

              return ListView.builder(
                itemCount: bookingController.filteredBookings.length,
                itemBuilder: (context, index) {
                  final booking = bookingController.filteredBookings[index];
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 0.01.w),
                    child: ListTile(
                      onTap: () {
                        // Navigate to the details screen and pass the booking object
                        Get.to(() => BookingDetailsScreen(booking: booking));
                      },
                      title: Text('Booking ${booking.id}'),
                      subtitle: Text('Status: ${booking.status}'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (_) {
                                  return UpdateStatusDialog(
                                    initialStatus: booking.status,
                                    onUpdate: (updatedStatus) {
                                      bookingController.updateBookingStatus(
                                          booking.id, updatedStatus);
                                      bookingController
                                          .fetchBookings(); // Refresh the booking list
                                    },
                                  );
                                },
                              );
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (_) {
                                  return CustomDeleteDialog(
                                    title: 'Delete Booking',
                                    content:
                                        'Are you sure you want to delete this booking?',
                                    deleteButtonText: 'Delete',
                                    onDelete: () {
                                      bookingController
                                          .deleteBooking(booking.id);
                                      bookingController
                                          .fetchBookings(); // Refresh the booking list
                                    },
                                  );
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
