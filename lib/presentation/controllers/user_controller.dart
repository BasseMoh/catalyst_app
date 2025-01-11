import 'package:catalyst_app/data/datasources/api_service.dart';
import 'package:catalyst_app/data/models/user_model.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  RxList<User> users = <User>[].obs;
  RxList<User> filteredUsers = <User>[].obs;
  RxBool isLoading = false.obs;
  RxString selectedRole = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchUsers(); // Fetch users when the controller is initialized
  }

  void fetchUsers() async {
    try {
      isLoading(true); // Set loading to true while fetching
      final fetchedUsers =
          await ApiService.getUsers(); // Fetch users from the API

      print(fetchedUsers); // Log the fetched data to debug

      if (fetchedUsers.isNotEmpty) {
        users.value = fetchedUsers; // Directly assign the list of users
        filteredUsers.value = users; // Set filtered list initially to all users
      } else {
        print("No users fetched.");
      }
    } catch (e) {
      print("Error fetching users: $e");
    } finally {
      isLoading(false); // Ensure loading is set to false after fetching
    }
  }

  // Method to filter users by the role (Owner, Client, Admin)
  void filterUsersByRole(String role) {
    selectedRole.value = role; // Set the selected role to the given one
    if (role.isEmpty) {
      filteredUsers.value = users; // If no role is selected, show all users
    } else {
      filteredUsers.value = users
          .where((user) => user.role.toLowerCase() == role.toLowerCase())
          .toList(); // Filter based on the role
    }
  }

  // Method to search users by name
  void searchUsers(String query) {
    filteredUsers.value = users
        .where((user) => user.name.toLowerCase().contains(query.toLowerCase()))
        .toList(); // Filter users by name based on the search query
  }

  // Method to create a new user
  void createUser(User user) async {
    try {
      await ApiService.createUser(user);
      users.add(user); // Add the new user to the users list
      filteredUsers.add(user); // Add the new user to the filtered list as well
    } catch (e) {
      print("Error creating user: $e");
    }
  }

   // Method to update an existing user
  void updateUser(int id, User updatedUser) async {
    try {
      final isUpdated = await ApiService.updateUser(id, updatedUser);
      if (isUpdated) {
        // If the update is successful, update the user in the list
        final userIndex = users.indexWhere((user) => user.id == id);
        if (userIndex != -1) {
          users[userIndex] = updatedUser; // Update the local list with the new user data
          
          // Update the filtered list as well if needed
          final filteredIndex = filteredUsers.indexWhere((user) => user.id == id);
          if (filteredIndex != -1) {
            filteredUsers[filteredIndex] = updatedUser; // Update the filtered list with the new data
          }
        }
      }
    } catch (e) {
      print("Error updating user: $e");
    }
  }


  // Method to delete a user
  void deleteUser(int id) async {
    try {
      await ApiService.deleteUser(id);
      users.removeWhere(
          (user) => user.id == id); // Remove the user from the list
      filteredUsers
          .removeWhere((user) => user.id == id); // Remove from filtered list
    } catch (e) {
      print("Error deleting user: $e");
    }
  }
}
