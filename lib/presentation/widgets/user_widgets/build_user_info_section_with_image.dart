import 'package:catalyst_app/core/utils/screen_size.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget buildUserInfoSectionWithImage({
    required String label,
    required String value,
    required IconData icon,
    required String imageUrl,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: 0.02.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 0.05.w,
            child:
                imageUrl.isNotEmpty ? null : Icon(Icons.person, size: 0.05.w),
            backgroundImage:
                imageUrl.isNotEmpty ? NetworkImage(imageUrl) : null,
            backgroundColor: Colors.grey[200],
          ),
          SizedBox(width: 0.03.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label.capitalize!,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 0.018.h,
                    color: Colors.black54,
                  ),
                ),
                SizedBox(height: 0.01.h),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 0.020.h,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }