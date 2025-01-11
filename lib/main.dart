import 'package:catalyst_app/core/utils/app_theme.dart';
import 'package:catalyst_app/presentation/pages/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'CRUD Operations',
      theme: ThemeData(
        primaryColor: AppTheme.primaryColor,
        progressIndicatorTheme: ProgressIndicatorThemeData(
          color: AppTheme.primaryColor,
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
