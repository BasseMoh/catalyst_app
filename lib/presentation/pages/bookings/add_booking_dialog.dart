import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddBookingDialog extends StatelessWidget {
  final Function({
    required int bookingId,
    required String status,
    required String startDate,
    required String endDate,
  }) onSave;

  const AddBookingDialog({
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    final bookingIdController = TextEditingController();
    final statusController = TextEditingController();
    final startDateController = TextEditingController();
    final endDateController = TextEditingController();

    return AlertDialog(
      title: const Text('Add New Booking'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Booking ID input field
            TextField(
              controller: bookingIdController,
              decoration: const InputDecoration(labelText: 'Booking ID'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 10),
            // Status input field
            TextField(
              controller: statusController,
              decoration: const InputDecoration(labelText: 'Status'),
            ),
            const SizedBox(height: 10),
            // Start date input field
            TextField(
              controller: startDateController,
              decoration: const InputDecoration(labelText: 'Start Date'),
            ),
            const SizedBox(height: 10),
            // End date input field
            TextField(
              controller: endDateController,
              decoration: const InputDecoration(labelText: 'End Date'),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Get.back(),
          child:   Text('Cancel', style: TextStyle(color: Theme.of(context).primaryColor),),
        ),
        TextButton(
          onPressed: () {
            final bookingId = int.tryParse(bookingIdController.text);
            final status = statusController.text;
            final startDate = startDateController.text;
            final endDate = endDateController.text;

            // Validate the fields
            if (bookingId == null ||
                status.isEmpty ||
                startDate.isEmpty ||
                endDate.isEmpty) {
              // Show validation error message
              Get.snackbar('Error', 'Please fill all fields correctly');
              return;
            }

            // Call the onSave callback
            onSave(
              bookingId: bookingId,
              status: status,
              startDate: startDate,
              endDate: endDate,
            );
            Get.back();
          },
          child: Text(
            'Save',
            style: TextStyle(color: Theme.of(context).primaryColor),
          ),
        ),
      ],
    );
  }
}
