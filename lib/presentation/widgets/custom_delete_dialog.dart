import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomDeleteDialog extends StatelessWidget {
  final String title;
  final String content;
  final String deleteButtonText;
  final VoidCallback onDelete;

  const CustomDeleteDialog({
    Key? key,
    required this.title,
    required this.content,
    required this.deleteButtonText,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        TextButton(
          onPressed: () => Get.back(),
          child: Text('Cancel', style: TextStyle(color: Theme.of(context).primaryColor)),
        ),
        TextButton(
          onPressed: () {
            onDelete();
            Get.back();
          },
          child: Text(deleteButtonText, style: TextStyle(color: Theme.of(context).primaryColor)),
        ),
      ],
    );
  }
}
