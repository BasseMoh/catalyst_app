import 'package:catalyst_app/data/models/user_model.dart';
import 'package:catalyst_app/presentation/controllers/user_controller.dart';
import 'package:catalyst_app/presentation/pages/user/show_user_dialog.dart';
import 'package:catalyst_app/presentation/pages/user/user_list_tile.dart';
import 'package:catalyst_app/presentation/widgets/custom_delete_dialog.dart';
import 'package:catalyst_app/presentation/widgets/custom_drop_down_button.dart';
import 'package:catalyst_app/presentation/widgets/custom_search_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UsersScreen extends StatefulWidget {
  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  final UserController userController = Get.put(UserController());
  String selectedRole = '';
  final List<String> roles = ['Owner', 'Client', 'Admin'];

  // Method to show the user dialog
  void _showUserDialog(BuildContext context, [User? user]) {
    UserDialog.showUserDialog(context, user, userController);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Users'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _showUserDialog(context),
          ),
        ],
      ),
      body: Column(
        children: [
          /// Custom search field
          CustomSearchTextField(
            labelText: 'Search by name',
            onChanged: userController.searchUsers,
          ),

          /// Custom dropdown for role selection
          CustomDropdownButton(
            selectedValue: selectedRole,
            hint: 'Select Role',
            items:  roles,
            onChanged: (newRole) {
              setState(() {
                selectedRole = newRole ?? '';
              });
              userController.filterUsersByRole(selectedRole);
            },
          ),

          /// Users list
          Expanded(
            child: Obx(
              () {
                if (userController.isLoading.value) {
                  return Center(child: CircularProgressIndicator());
                } else if (userController.filteredUsers.isEmpty) {
                  return Center(child: Text('No Users Found.'));
                } else {
                  return ListView.builder(
                    itemCount: userController.filteredUsers.length,
                    itemBuilder: (context, index) {
                      final user = userController.filteredUsers[index];
                      return UserListTile(
                        user: user,
                        onEdit: (user) {
                          _showUserDialog(context, user);
                        },
                        onDelete: (userId) {
                          showDialog(
                            context: context,
                            builder: (_) {
                              return CustomDeleteDialog(
                                title: 'Delete User',
                                content:
                                    'Are you sure you want to delete ${user.name}?',
                                deleteButtonText: 'Delete',
                                onDelete: () {
                                  userController.deleteUser(userId);
                                },
                              );
                            },
                          );
                        },
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }


}
