import 'package:flutter/material.dart';

class StoryItem extends StatelessWidget {
  final String name;
  final String imageUrl;
  final bool isLive;
  final bool isUser;

  const StoryItem({
    super.key,
    required this.name,
    required this.imageUrl,
    this.isLive = false,
    this.isUser = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            alignment: Alignment.bottomCenter,
            children: [
              // 1. The Gradient Ring
              Container(
                width: 80,
                height: 80,
                padding: const EdgeInsets.all(3), // Thickness of the ring
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  // If it's the user's story, we don't usually show the gradient
                  gradient: isUser
                      ? null
                      : const LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                          colors: [
                            Color(0xFF833AB4), // Purple
                            Color(0xFFFD1D1D), // Red
                            Color(0xFFFCAF45), // Yellow/Orange
                          ],
                        ),
                ),
                child: Container(
                  padding: const EdgeInsets.all(3), // The black gap between ring and photo
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(imageUrl),
                  ),
                ),
              ),

              // 2. The Blue "Add" icon (only for 'Your Story')
              if (isUser)
                Positioned(
                  right: 0,
                  bottom: 5,
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Container(
                      padding: const EdgeInsets.all(2),
                      decoration: const BoxDecoration(
                        color: Colors.black,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 16,
                      ),
                    ),
                  ),
                ),

              // 3. The "LIVE" Badge
              if (isLive)
                Positioned(
                  bottom: 0,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: const Color(0xFFD62976), // Instagram Live Pink
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(color: Colors.white10, width: 2),
                    ),
                    child: const Text(
                      "LIVE",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 8),
          // 4. The Username
          SizedBox(
            width: 80,
            child: Text(
              name,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 12,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}