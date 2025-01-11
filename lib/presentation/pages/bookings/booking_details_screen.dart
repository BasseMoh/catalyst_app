import 'package:carousel_slider/carousel_slider.dart';
import 'package:catalyst_app/core/utils/date_format.dart';
import 'package:flutter/material.dart';
import 'package:catalyst_app/core/utils/screen_size.dart';
import 'package:catalyst_app/data/models/booking_model.dart';
import 'package:catalyst_app/presentation/widgets/custom_appbar.dart';
import 'package:get/get.dart';

class BookingDetailsScreen extends StatelessWidget {
  final Booking booking;

  BookingDetailsScreen({required this.booking});
 
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Booking Details',
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 0.04.w, vertical: 0.015.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Property Image
              booking.property.images != null
                  ? CarouselSlider(
                      items: booking.property.images.map((imageUrl) {
                        final fullImageUrl =
                            'https://test.catalystegy.com/public/$imageUrl';
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(12.0),
                          child: Image.network(
                            fullImageUrl,
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: 0.4.h,
                          ),
                        );
                      }).toList(),
                      options: CarouselOptions(
                        height: 0.25.h,
                        enlargeCenterPage: true,
                        enableInfiniteScroll: false,
                        viewportFraction: 1.0,
                      ),
                    )
                  : SizedBox(),
              SizedBox(height: 0.02.h),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Booking Details
                  _buildSectionCard(
                    title: 'Booking Details',
                    content: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildDetailRow('Booking ID', booking.id.toString()),
                        _buildDetailRow('Status', booking.status),
                        _buildDetailRow('Start Date', formatDate(booking.startDate)),
                        _buildDetailRow('End Date',formatDate(booking.endDate)),
                        _buildDetailRow('Created At', formatDate(booking.createdAt)),
                        _buildDetailRow('Updated At', formatDate(booking.updatedAt)),
                      ],
                    ),
                  ),

                  SizedBox(height: 0.02.h),

                  // User Details
                  _buildSectionCard(
                    title: 'User Details',
                    content: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildDetailRow('Name', booking.user.name),
                        _buildDetailRow('Email', booking.user.email),
                        _buildDetailRow('Phone', booking.user.phone),
                      ],
                    ),
                  ),

                  SizedBox(height: 0.02.h),

                  // Property Details
                  _buildSectionCard(
                    title: 'Property Details',
                    content: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildDetailRow('Location', booking.property.location),
                        _buildDetailRow('Price', '\$${booking.property.price}'),
                        _buildDetailRow(
                            'Description', booking.property.description),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionCard({required String title, required Widget content}) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding:   EdgeInsets.symmetric(horizontal: 0.04.w, vertical: 0.015.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 0.025.h,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 0.01.h),
            content,
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding:   EdgeInsets.symmetric(  vertical: 0.01.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$label:',
            style: TextStyle(
              fontSize: 0.020.h,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(width: 0.02.w),
          Expanded(
            child: Text(
              value.capitalize!,
              style: TextStyle(
                fontSize: 0.020.h,
                color: Colors.grey[700],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
