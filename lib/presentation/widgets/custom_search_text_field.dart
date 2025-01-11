import 'package:catalyst_app/core/utils/screen_size.dart';
import 'package:flutter/material.dart';

class CustomSearchTextField extends StatelessWidget {
  final String labelText;
  final Function(String)? onChanged;

  CustomSearchTextField({required this.labelText, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 0.05.w,vertical: 0.015.h),
      child: TextField(
        onChanged: onChanged,
        decoration: InputDecoration(
          labelText: labelText,
          border: OutlineInputBorder(),
          prefixIcon: Icon(Icons.search),
        ),
      ),
    );
  }
}
