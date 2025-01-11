import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UpdateStatusDialog extends StatelessWidget {
  final String initialStatus;
  final Function(String updatedStatus) onUpdate;

  UpdateStatusDialog({
    required this.initialStatus,
    required this.onUpdate,
  });

  @override
  Widget build(BuildContext context) {
    final TextEditingController statusController =
        TextEditingController(text: initialStatus);

    return AlertDialog(
      title: Text('Update Booking Status'),
      content: TextField(
        controller: statusController,
        decoration: InputDecoration(labelText: 'Status'),
      ),
      actions: [
        TextButton(
          onPressed: () => Get.back(),
           child:   Text('Cancel', style: TextStyle(color: Theme.of(context).primaryColor),),
        ),
        TextButton(
          onPressed: () {
            onUpdate(statusController.text);
            Get.back();
          },
          child: Text(
            'Update',
            style: TextStyle(color: Theme.of(context).primaryColor),
          ),
        ),
      ],
    );
  }
}
