import 'package:catalyst_app/core/utils/screen_size.dart';
import 'package:catalyst_app/data/models/user_model.dart';
import 'package:catalyst_app/presentation/pages/user/user_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserListTile extends StatelessWidget {
  final User user;
  final Function(User) onEdit;
  final Function(int) onDelete;

  UserListTile({
    required this.user,
    required this.onEdit,
    required this.onDelete,
  });

  final TextStyle leadingTextStyle = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 0.020.h,
    color: Colors.black,
  );

  final TextStyle trailingTextStyle = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 0.018.h,
    color: Colors.black,
  );

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        // Navigate to UserDetailsScreen and pass the user object
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => UserDetailsScreen(user: user),
          ),
        );
      },
      leading: user.profileImage != ''
          ? CircleAvatar(
              radius: 0.05.w,
              backgroundImage: NetworkImage(user.profileImage),
            )
          : CircleAvatar(
              radius: 0.05.w,
              child: Icon(Icons.person, size: 0.05.w),
            ),
      title: Text(
        user.name.capitalize!,
        style: leadingTextStyle,
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            user.email,
            style: trailingTextStyle,
          ),
          SizedBox(height: 0.005.h),
          Text(
            user.role.capitalize!,
            style: TextStyle(
              fontSize: 0.015.h,
              color: Colors.blueGrey,
            ),
          ), // Show role under email
        ],
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Edit Button
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () => onEdit(user),
          ),
          // Delete Button
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () => onDelete(user.id),
          ),
        ],
      ),
    );
  }
}
