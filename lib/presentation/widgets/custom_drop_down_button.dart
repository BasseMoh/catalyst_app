import 'package:catalyst_app/core/utils/screen_size.dart';
import 'package:flutter/material.dart';

class CustomDropdownButton extends StatelessWidget {
  final String? selectedValue;
  final String hint;
  final List<String> items;
  final Function(String?) onChanged;

  CustomDropdownButton({
    required this.selectedValue,
    required this.hint,
    required this.items,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 0.05.w,vertical: 0.01.h),
      child: DropdownButton<String>(
        value: selectedValue?.isEmpty ?? true ? null : selectedValue,
        hint: Text(hint),
        onChanged: onChanged,
        items: items.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }
}
