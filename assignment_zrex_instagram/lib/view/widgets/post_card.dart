import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:pinch_zoom_release_unzoom/pinch_zoom_release_unzoom.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class PostCard extends StatefulWidget {
  final String username;
  final String profileImage;
  final List<String> images;

  const PostCard({
    super.key,
    required this.username,
    required this.profileImage,
    required this.images,
  });

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  final PageController _pageController = PageController();
  bool _isLiked = false;
  bool _isSaved = false;
  bool _blockScroll = false; // Prevents swiping while pinching

  void _showUnimplementedSnackBar(BuildContext context, String feature) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$feature feature is coming soon!'),
        duration: const Duration(seconds: 2),
        backgroundColor: Colors.grey[900],
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // --- Header Section ---
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Row(
            children: [
              CircleAvatar(
                radius: 18,
                backgroundImage: NetworkImage(widget.profileImage),
              ),
              const SizedBox(width: 10),
              Text(
                widget.username,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(width: 4),
              const Icon(Icons.verified, color: Colors.blue, size: 14),
              const Spacer(),
              IconButton(
                icon: const Icon(Icons.more_vert, color: Colors.black),
                onPressed: () => _showPostOptions(context),
              ),
            ],
          ),
        ),

        // --- Carousel & Zoom Section ---
        SizedBox(
          height: 400,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              // FIXED: Added PageView to allow multiple images
              PageView.builder(
                controller: _pageController,

                physics: _blockScroll
                    ? const NeverScrollableScrollPhysics()
                    : const BouncingScrollPhysics(),
                itemCount: widget.images.length,
                itemBuilder: (context, index) {
                  return PinchZoomReleaseUnzoomWidget(
                    useOverlay: true,
                    minScale: 1.0,
                    maxScale: 4.0,
                    resetDuration: const Duration(milliseconds: 200),
                    maxOverlayOpacity: 0.5,
                    overlayColor: Colors.black,
                    fingersRequiredToPinch: 2,

                    child: Image.network(
                      widget.images[index],
                      fit: BoxFit.cover,
                      cacheWidth: 800,
                    ),
                  );
                },
              ),

              // --- Dot Indicator ---
              if (widget.images.length > 1 && !_blockScroll)
                Positioned(
                  bottom: 15,
                  child: SmoothPageIndicator(
                    controller: _pageController,
                    count: widget.images.length,
                    effect: const ScrollingDotsEffect(
                      dotWidth: 6,
                      dotHeight: 6,
                      activeDotColor: Colors.blue,
                      dotColor: Colors.white,
                    ),
                  ),
                ),
            ],
          ),
        ),

        // --- Interaction Bar ---
        Row(
          children: [
            IconButton(
              icon: Icon(
                _isLiked ? Icons.favorite : Icons.favorite_border,
                color: _isLiked ? Colors.red : Colors.black,
              ),
              onPressed: () => setState(() => _isLiked = !_isLiked),
            ),
            IconButton(
              icon: const Icon(Iconsax.message_2_copy, color: Colors.black),
              onPressed: () => _showUnimplementedSnackBar(context, 'Comments'),
            ),
            IconButton(
              icon: const Icon(
                Iconsax.repeat_copy,
                color: Colors.black,
                size: 24,
              ),
              onPressed: () {
                _showUnimplementedSnackBar(context, 'Repost');
              },
            ),
            IconButton(
              icon: Transform.rotate(
                angle: -45 * 3.1415926535 / 180,
                child: Icon(Iconsax.direct_right_copy),
              ),
              onPressed: () => _showUnimplementedSnackBar(context, 'Share'),
            ),
            const Spacer(),
            IconButton(
              icon: Icon(
                _isSaved ? Iconsax.archive_1 : Iconsax.archive_1_copy,
                color: Colors.black,
              ),
              onPressed: () => setState(() => _isSaved = !_isSaved),
            ),
          ],
        ),
      ],
    );
  }

  void _showPostOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.only(top: 12, bottom: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // 1. Top Drag Handle
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              const SizedBox(height: 20),

              // 2. The Circle Button Row (Save and QR Code)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildCircleButton(Iconsax.archive_1_copy, 'Save'),
                  _buildCircleButton(Iconsax.scan_barcode_copy, 'QR code'),
                ],
              ),
              const SizedBox(height: 10),
              const Divider(thickness: 0.5),

              // 3. List of Options
              _buildListOption(Iconsax.star_copy, 'Add to favorites'),
              _buildListOption(Iconsax.user_minus_copy, 'Unfollow'),
              const Divider(thickness: 0.5),
              _buildListOption(
                Iconsax.info_circle_copy,
                "Why you're seeing this post",
              ),
              _buildListOption(Iconsax.eye_slash_copy, 'Hide'),
              _buildListOption(Iconsax.personalcard_copy, 'About this account'),

              // 4. Dangerous Option
              _buildListOption(
                Iconsax.danger_copy,
                'Report',
                textColor: Colors.red,
                iconColor: Colors.red,
              ),
            ],
          ),
        );
      },
    );
  }

  // Helper for the Top Circle Buttons
  Widget _buildCircleButton(IconData icon, String label) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.grey.shade300, width: 1.5),
          ),
          child: Icon(icon, size: 28, color: Colors.black),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }

  // Helper for the List Rows
  Widget _buildListOption(
    IconData icon,
    String title, {
    Color textColor = Colors.black,
    Color iconColor = Colors.black,
  }) {
    return ListTile(
      leading: Icon(icon, color: iconColor, size: 24),
      title: Text(
        title,
        style: TextStyle(
          color: textColor,
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
      ),
      onTap: () {
        Navigator.pop(context);
        _showUnimplementedSnackBar(context, title);
      },
    );
  }
}
