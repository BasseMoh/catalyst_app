import 'package:catalyst_app/core/utils/screen_size.dart';
import 'package:catalyst_app/presentation/controllers/property_controller.dart';
import 'package:catalyst_app/presentation/pages/properties/property_card.dart';
import 'package:catalyst_app/presentation/pages/properties/property_dialog.dart';
import 'package:catalyst_app/presentation/widgets/custom_search_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PropertiesScreen extends StatelessWidget {
  final PropertyController propertyController = Get.put(PropertyController());

  @override
  Widget build(BuildContext context) {
    propertyController.fetchProperties();

    return Scaffold(
      appBar: AppBar(
        title: Text('Properties'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () =>
                PropertyDialog.showPropertyDialog(context, propertyController),
          ),
        ],
      ),
      body: Column(
        children: [
          /// custom search field
          CustomSearchTextField(
            labelText: 'Search by name',
            onChanged: (query) => propertyController.filterProperties(query),
          ),
          // Properties list
          Expanded(
            child: Obx(() {
              if (propertyController.isLoading.value) {
                return Center(child: CircularProgressIndicator());
              }

              final properties = propertyController.filteredProperties;

              if (properties.isEmpty) {
                return Center(child: Text('No properties found'));
              }

              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 0.05.w),
                child: ListView.builder(
                  itemCount: properties.length,
                  itemBuilder: (context, index) {
                    final property = properties[index];
                    return PropertyCard(
                      property: property,
                      propertyController: propertyController,
                    );
                  },
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
