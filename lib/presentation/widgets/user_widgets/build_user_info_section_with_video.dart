
import 'package:catalyst_app/core/utils/screen_size.dart';
import 'package:flutter/material.dart';
import 'package:catalyst_app/core/utils/app_theme.dart';
import 'package:get/get.dart';

Widget buildUserInfoSectionWithVideo({
  required String label,
  required String value,
  required IconData icon,
  required double fontSize,
  required String videoUrl,
  required bool isVideoPlaying,
  required VoidCallback onPlayPausePressed,
  required Widget videoPlayerWidget,
}) {
  return Padding(
    padding: EdgeInsets.only(bottom: 0.02.h),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          color: AppTheme.secondaryColor.withOpacity(0.7),
          size: 0.03.h,
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
                  fontSize: fontSize,
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 0.01.h),
              videoUrl.isNotEmpty
                  ? ElevatedButton(
                      onPressed: onPlayPausePressed,
                      child: Text(
                        isVideoPlaying ? 'Pause Video' : 'Watch Intro Video',
                        style: TextStyle(color: AppTheme.primaryColor),
                      ),
                    )
                  : Container(),
              if (isVideoPlaying) videoPlayerWidget,
            ],
          ),
        ),
      ],
    ),
  );
}
