import 'package:catalyst_app/core/utils/screen_size.dart';
import 'package:catalyst_app/data/models/property_model.dart';
import 'package:catalyst_app/presentation/controllers/property_controller.dart';
import 'package:catalyst_app/presentation/pages/properties/property_details_screen.dart';
import 'package:catalyst_app/presentation/widgets/custom_delete_dialog.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:get/get.dart';
import 'property_dialog.dart';

class PropertyCard extends StatelessWidget {
  final Property property;
  final PropertyController propertyController;

  const PropertyCard({
    required this.property,
    required this.propertyController,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Navigate to PropertyDetailsScreen
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PropertyDetailsScreen(property: property),
          ),
        );
      },
      child: Card(
        margin: EdgeInsets.symmetric(vertical: 0.01.h),
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CarouselSlider(
              items: property.images.map((imageUrl) {
                final fullImageUrl =
                    'https://test.catalystegy.com/public/$imageUrl';
                return ClipRRect(
                  borderRadius: BorderRadius.circular(12.0),
                  child: Image.network(
                    fullImageUrl,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: 0.4.h,
                  ),
                );
              }).toList(),
              options: CarouselOptions(
                height: 0.25.h,
                enlargeCenterPage: true,
                enableInfiniteScroll: false,
                viewportFraction: 1.0,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                property.name.capitalize!,
                style:
                    TextStyle(fontSize: 0.024.h, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                property.location,
                style: TextStyle(fontSize: 0.018.h, color: Colors.grey),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '\$${property.price}',
                    style: TextStyle(
                        fontSize: 0.024.h, fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () => PropertyDialog.showPropertyDialog(
                            context, propertyController, property),
                      ),
                      IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () => {
                                showDialog(
                                  context: context,
                                  builder: (_) {
                                    return CustomDeleteDialog(
                                      title: 'Delete Property',
                                      content:
                                          'Are you sure you want to delete this property?',
                                      deleteButtonText: 'Delete',
                                      onDelete: () {
                                        propertyController
                                            .deleteProperty(property.id);
                                      },
                                    );
                                  },
                                )
                              }),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
