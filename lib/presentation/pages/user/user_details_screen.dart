import 'package:catalyst_app/core/utils/date_format.dart';
import 'package:catalyst_app/core/utils/screen_size.dart';
import 'package:catalyst_app/presentation/widgets/custom_appbar.dart';
import 'package:catalyst_app/presentation/widgets/user_widgets/build_user_info_section.dart';
import 'package:catalyst_app/presentation/widgets/user_widgets/build_user_info_section_with_image.dart';
import 'package:catalyst_app/presentation/widgets/user_widgets/build_user_info_section_with_video.dart';
import 'package:flutter/material.dart';
import 'package:catalyst_app/data/models/user_model.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class UserDetailsScreen extends StatefulWidget {
  final User user;

  UserDetailsScreen({required this.user});

  @override
  _UserDetailsScreenState createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreen> {
  late VideoPlayerController _videoPlayerController;
  bool _isVideoPlaying = false;
 

  @override
  void dispose() {
    if (_isVideoPlaying) {
      _videoPlayerController.dispose();
    }
    super.dispose();
  }

  void _playIntroVideo(String videoUrl) {
    _videoPlayerController = VideoPlayerController.network(videoUrl)
      ..initialize().then((_) {
        setState(() {
          _isVideoPlaying = true;
        });
        _videoPlayerController.play();
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: '${widget.user.name.capitalize} Details',
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 0.05.w, vertical: 0.015.h),
        child: ListView(
          children: [
            buildUserInfoSectionWithImage(
              label: 'Name',
              value: widget.user.name.capitalize!,
              icon: Icons.person,
              imageUrl: widget.user.profileImage,
            ),
            buildUserInfoSection(
              label: 'Email',
              value: widget.user.email,
              icon: Icons.email,
            ),
            buildUserInfoSection(
              label: 'Phone',
              value: widget.user.phone,
              icon: Icons.phone,
            ),
            buildUserInfoSection(
              label: 'Role',
              value: widget.user.role.capitalize!,
              icon: Icons.account_circle,
            ),
            buildUserInfoSection(
              label: 'Profile Image',
              value: widget.user.profileImage.isNotEmpty
                  ? 'Available'
                  : 'Not Available',
              icon: Icons.image,
            ),
             buildUserInfoSectionWithVideo(
              label: 'Intro Video',
              value: widget.user.introVideo.isNotEmpty
                  ? 'Available'
                  : 'Not Available',
              icon: Icons.video_library,
              fontSize: 16,
              videoUrl: widget.user.introVideo,
              isVideoPlaying: _isVideoPlaying,
              onPlayPausePressed: () {
                if (!_isVideoPlaying) {
                  _playIntroVideo(widget.user.introVideo);
                } else {
                  setState(() {
                    _isVideoPlaying = false;
                  });
                  _videoPlayerController.pause();
                }
              },
              videoPlayerWidget: _isVideoPlaying
                  ? Container(
                      padding: EdgeInsets.symmetric(vertical: 0.01.h),
                      child: AspectRatio(
                        aspectRatio: _videoPlayerController.value.aspectRatio,
                        child: VideoPlayer(_videoPlayerController),
                      ),
                    )
                  : Container(),
            ),
            buildUserInfoSection(
              label: 'Created At',
              value: formatDate(widget.user.createdAt),
              icon: Icons.access_time,
            ),
            buildUserInfoSection(
              label: 'Updated At',
              value: formatDate(widget.user.updatedAt),
              icon: Icons.update,
            ),
          ],
        ),
      ),
    );
  }

  
}
