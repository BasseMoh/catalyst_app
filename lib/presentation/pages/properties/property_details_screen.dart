import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:catalyst_app/core/utils/date_format.dart';
import 'package:catalyst_app/core/utils/screen_size.dart';
import 'package:catalyst_app/presentation/widgets/custom_appbar.dart';
import 'package:catalyst_app/presentation/widgets/user_widgets/build_user_info_section.dart';
import 'package:flutter/material.dart';
import 'package:catalyst_app/data/models/property_model.dart';
import 'package:intl/intl.dart';
import 'package:video_player/video_player.dart';

class PropertyDetailsScreen extends StatefulWidget {
  final Property property;

  PropertyDetailsScreen({required this.property});

  @override
  State<PropertyDetailsScreen> createState() => _PropertyDetailsScreenState();
}

class _PropertyDetailsScreenState extends State<PropertyDetailsScreen> {
 late VideoPlayerController _videoPlayerController;
  bool isVideoPlaying = false;
 

  @override
  void dispose() {
    if (isVideoPlaying) {
      _videoPlayerController.dispose();
    }
    super.dispose();
  }

  void _playIntroVideo(String videoUrl) {
    _videoPlayerController = VideoPlayerController.network(videoUrl)
      ..initialize().then((_) {
        setState(() {
          isVideoPlaying = true;
        });
        _videoPlayerController.play();
      });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: widget.property.name,),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 0.05.w),
        child: ListView(
          children: [
            // Show images if available
            if (widget.property.images.isNotEmpty)
              CarouselSlider(
                items: widget.property.images.map((imageUrl) {
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
              ),
            if (widget.property.images.isNotEmpty)
              SizedBox(
                height: 0.025.h,
              ),
            // Name and Location Sections
            buildUserInfoSection(
              label: 'Name',
              value: widget.property.name,
              icon: Icons.home,
            ),
            buildUserInfoSection(
              label: 'Location',
              value: widget.property.location,
              icon: Icons.location_on,
            ),
            buildUserInfoSection(
              label: 'Price',
              value: '\$${widget.property.price}',
              icon: Icons.attach_money,
            ),

            // Show video if available
             // Show video section with play/pause functionality
            // if (widget.property.video.isNotEmpty)
            //   buildUserInfoSectionWithVideo(
            //     label: 'Video',
            //     value:  widget.property.video.isNotEmpty
            //       ? 'Available'
            //       : 'Not Available',
            //     icon: Icons.videocam,
            //     fontSize: 0.02.h,
            //     videoUrl: widget.property.video,
            //     isVideoPlaying: isVideoPlaying,
            //     onPlayPausePressed:  () {
            //     if (!isVideoPlaying) {
            //       _playIntroVideo(widget.property.video);
            //     } else {
            //       setState(() {
            //         isVideoPlaying = false;
            //       });
            //       _videoPlayerController.pause();
            //     }
            //   },
            //     videoPlayerWidget: isVideoPlaying
            //       ? Container(
            //           padding: EdgeInsets.symmetric(vertical: 0.01.h),
            //           child: AspectRatio(
            //             aspectRatio: _videoPlayerController.value.aspectRatio,
            //             child: VideoPlayer(_videoPlayerController),
            //           ),
            //         )
            //       : Container(),
            //   ),

            // Show creation and update time
            buildUserInfoSection(
              label: 'Created At',
              value: formatDate(widget.property.createdAt),
              icon: Icons.date_range,
            ),
            buildUserInfoSection(
              label: 'Updated At',
              value: formatDate(widget.property.updatedAt),
              icon: Icons.update,
            ),
          ],
        ),
      ),
    );
  }
}
