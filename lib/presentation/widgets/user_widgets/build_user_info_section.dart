import 'package:catalyst_app/core/utils/app_theme.dart';
import 'package:catalyst_app/core/utils/screen_size.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget buildUserInfoSection({
    required String label,
    required String value,
    required IconData icon,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: 0.02.h),
      child: Row(
         crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon,
              color: AppTheme.secondaryColor.withOpacity(0.7), size: 0.03.h),
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
                SizedBox(height: 4),
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