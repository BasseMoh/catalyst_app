import 'package:catalyst_app/presentation/controllers/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:catalyst_app/data/models/user_model.dart';
import 'package:get/get.dart';

class UserDialog {
  static void showUserDialog(
      BuildContext context, User? user, UserController userController) {
    final nameController = TextEditingController(text: user?.name ?? '');
    final emailController = TextEditingController(text: user?.email ?? '');
    final phoneController = TextEditingController(text: user?.phone ?? '');
    final List<String> roles = ['Owner', 'Client', 'Admin'];

    // Role selection: Make sure the role is from the available list
    String role = user?.role ??
        (roles.isNotEmpty
            ? roles[0]
            : ''); // Ensure there's at least one role available
    if (!roles.contains(role)) {
      role = roles.isNotEmpty
          ? roles[0]
          : ''; // Default to the first role if the selected role is invalid
    }

    // Default values for profile image and intro video
    String profileImageUrl = user?.profileImage ?? '';
    String introVideoUrl = user?.introVideo ?? '';

    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Text(user == null ? 'Add User' : 'Edit User'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Name'),
              ),
              TextField(
                controller: emailController,
                decoration: InputDecoration(labelText: 'Email'),
              ),
              TextField(
                controller: phoneController,
                decoration: InputDecoration(labelText: 'Phone'),
              ),
              TextField(
                controller: TextEditingController(text: profileImageUrl),
                decoration: InputDecoration(labelText: 'Profile Image URL'),
                onChanged: (value) => profileImageUrl = value,
              ),
              TextField(
                controller: TextEditingController(text: introVideoUrl),
                decoration: InputDecoration(labelText: 'Intro Video URL'),
                onChanged: (value) => introVideoUrl = value,
              ),
              DropdownButton<String>(
                value: role,
                onChanged: (String? newRole) {
                  if (newRole != null) {
                    role = newRole;
                  }
                },
                items: roles.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Get.back(),
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (user == null) {
                  // Create new user
                  userController.createUser(User(
                    id: userController.filteredUsers.length +
                        1, // Set id to length of filteredUsers + 1

                    name: nameController.text,
                    email: emailController.text,
                    phone: phoneController.text,
                    role: role,
                    profileImage: profileImageUrl,
                    introVideo: introVideoUrl,
                    createdAt: DateTime.now().toIso8601String(),
                    updatedAt: DateTime.now().toIso8601String(),
                  ));
                } else {
                  // Update existing user
                  userController.updateUser(
                    user.id,
                    User(
                      id: user.id,
                      name: nameController.text,
                      email: emailController.text,
                      phone: phoneController.text,
                      role: role,
                      profileImage: profileImageUrl,
                      introVideo: introVideoUrl,
                      createdAt: user.createdAt,
                      updatedAt: DateTime.now().toIso8601String(),
                    ),
                  );
                }
                // Refetch the users to update the list
                userController
                    .fetchUsers(); // This will fetch the latest users list and update the UI
                Get.back(); // Close the dialog
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }
}
