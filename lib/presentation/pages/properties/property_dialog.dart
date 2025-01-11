import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:catalyst_app/data/models/property_model.dart';
import 'package:catalyst_app/presentation/controllers/property_controller.dart';

class PropertyDialog {
  static void showPropertyDialog(BuildContext context, PropertyController propertyController, [Property? property]) {
    final nameController = TextEditingController(text: property?.name ?? '');
    final priceController = TextEditingController(text: property?.price ?? '');
    final locationController = TextEditingController(text: property?.location ?? '');
    final descriptionController = TextEditingController(text: property?.description ?? '');
    final videoController = TextEditingController(text: property?.video ?? '');
    final createdAtController = TextEditingController(text: property?.createdAt ?? '');
    final updatedAtController = TextEditingController(text: property?.updatedAt ?? '');
    final userIdController = TextEditingController(text: property?.userId?.toString() ?? '');
    final imageController = TextEditingController(text: property?.images.isNotEmpty == true ? property?.images[0] : '');

    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Text(property == null ? 'Add Property' : 'Edit Property'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(controller: nameController, decoration: InputDecoration(labelText: 'Name')),
                TextField(controller: priceController, decoration: InputDecoration(labelText: 'Price')),
                TextField(controller: locationController, decoration: InputDecoration(labelText: 'Location')),
                TextField(controller: descriptionController, decoration: InputDecoration(labelText: 'Description')),
                TextField(controller: videoController, decoration: InputDecoration(labelText: 'Video URL')),
                TextField(controller: imageController, decoration: InputDecoration(labelText: 'Image URL')),
                TextField(controller: createdAtController, decoration: InputDecoration(labelText: 'Created At')),
                TextField(controller: updatedAtController, decoration: InputDecoration(labelText: 'Updated At')),
                TextField(controller: userIdController, decoration: InputDecoration(labelText: 'User ID')),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Get.back(),
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (property == null) {
                  // Create property
                  propertyController.createProperty(
                    Property(
                      id: 0,
                      name: nameController.text,
                      price: priceController.text,
                      location: locationController.text,
                      description: descriptionController.text,
                      images: [imageController.text],
                      video: videoController.text,
                      createdAt: createdAtController.text,
                      updatedAt: updatedAtController.text,
                      userId: int.tryParse(userIdController.text) ?? 0,
                    ),
                  );
                } else {
                  // Update property
                  propertyController.updateProperty(
                    property.id,
                    Property(
                      id: property.id,
                      name: nameController.text,
                      price: priceController.text,
                      location: locationController.text,
                      description: descriptionController.text,
                      images: [imageController.text],
                      video: videoController.text,
                      createdAt: createdAtController.text,
                      updatedAt: updatedAtController.text,
                      userId: int.tryParse(userIdController.text) ?? 0,
                    ),
                  );
                }
                Get.back();
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }
}
