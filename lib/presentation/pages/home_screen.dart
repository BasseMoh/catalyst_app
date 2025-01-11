import 'package:catalyst_app/core/utils/screen_size.dart';
import 'package:catalyst_app/presentation/pages/bookings/bookings_screen.dart';
import 'package:catalyst_app/presentation/pages/properties/properties_screen.dart';
import 'package:catalyst_app/presentation/pages/user/users_screen.dart';
import 'package:catalyst_app/presentation/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 0.04.w, vertical: 0.02.h),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/images/catalyst_logo.svg',
                height: 0.3.h,
                width: 0.6.w,
                fit: BoxFit.contain,
              ),
          
              Container(
                color: Colors.transparent,
                child: Lottie.asset(
                  'assets/images/home.json',
                  height: 0.4.h,
                  width: 0.9.w,
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(
                  height: 0.01.h),  
          
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // First Button
                  Expanded(
                    child: CustomElevatedButton(
                      text: 'Manage Users',
                      onPressed: () => Get.to(() => UsersScreen()),
                    ),
                  ),
                  SizedBox(width: 0.04.w),
          
                  // Second Button
                  Expanded(
                    child: CustomElevatedButton(
                      text: 'Manage Properties',
                      onPressed: () => Get.to(() => PropertiesScreen()),
                    ),
                  ),
                ],
              ),
              SizedBox(height:  0.03.h),
              CustomElevatedButton(
                text: 'Manage Bookings',
                onPressed: () => Get.to(() => BookingsScreen()),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
