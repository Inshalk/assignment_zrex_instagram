import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class PostShimmer extends StatelessWidget {
  const PostShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    
    // Define colors for the shimmer
    Color baseColor = isDarkMode ? Colors.grey[900]! : Colors.grey[300]!;
    Color highlightColor = isDarkMode ? Colors.grey[800]! : Colors.grey[100]!;

    return Shimmer.fromColors(
      baseColor: baseColor,
      highlightColor: highlightColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Skeleton
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                const CircleAvatar(radius: 18, backgroundColor: Colors.white),
                const SizedBox(width: 10),
                Container(width: 100, height: 12, color: Colors.white),
              ],
            ),
          ),
          // Image Skeleton
          Container(
            width: double.infinity,
            height: 400,
            color: Colors.white,
          ),
          // Actions Skeleton
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Container(width: 30, height: 30, color: Colors.white),
                const SizedBox(width: 15),
                Container(width: 30, height: 30, color: Colors.white),
                const SizedBox(width: 15),
                Container(width: 30, height: 30, color: Colors.white),
                const SizedBox(width: 15),
                Container(width: 30, height: 30, color: Colors.white),
              ],
            ),
          ),
        ],
      ),
    );
  }
}