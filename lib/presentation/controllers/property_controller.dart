import 'package:catalyst_app/data/datasources/api_service.dart';
import 'package:catalyst_app/data/models/property_model.dart';
import 'package:get/get.dart';

class PropertyController extends GetxController {
  var properties = <Property>[].obs; // Original list of properties
  var filteredProperties = <Property>[].obs; // Filtered list for search
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchProperties(); // Fetch properties when the controller is initialized
  }

  // Fetch properties from the API
  void fetchProperties() async {
    isLoading.value = true;
    final propertiesResponse = await ApiService.getProperties();

    if (propertiesResponse.isNotEmpty) {
      // Map each property response to a Property object
      properties.value = propertiesResponse
          .map((data) => Property.fromJson(data))
          .toList();
      filteredProperties.value = properties; // Sync the filtered list initially
    } else {
      print("No properties found!");
    }
    isLoading.value = false;
  }

// Create a property and add it to the beginning of the list
void createProperty(Property newProperty) async {
  final apiService = ApiService();  // Create an instance of ApiService
  final createdProperty = await apiService.createProperty(newProperty); // Call the instance method
  if (createdProperty != null) {
    properties.insert(0, createdProperty); // Add the new property at the beginning
    filterProperties(''); // Refresh the filtered list
  }
}

  // Update a property
  void updateProperty(int id, Property updatedProperty) async {
    final isUpdated = await ApiService.updateProperty(id, updatedProperty.toJson());
    if (isUpdated) {
      final index = properties.indexWhere((property) => property.id == id);
      if (index != -1) {
        properties[index] = updatedProperty; // Update the list with the new property details
        filterProperties(''); // Refresh the filtered list
      }
    }
  }

  // Delete a property
  void deleteProperty(int id) async {
    final isDeleted = await ApiService.deleteProperty(id);
    if (isDeleted) {
      properties.removeWhere((property) => property.id == id); // Remove the deleted property from the list
      filterProperties(''); // Refresh the filtered list
    }
  }

  // Search functionality to filter properties
  void filterProperties(String query) {
    if (query.isEmpty) {
      filteredProperties.value = properties;
    } else {
      filteredProperties.value = properties
          .where((property) => property.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    print("Filtered Properties: ${filteredProperties.value}"); // Add this line to see the filtered data
  }
}
