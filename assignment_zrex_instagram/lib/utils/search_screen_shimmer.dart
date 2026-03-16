import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class SearchScreenShimmer extends StatelessWidget {
  const SearchScreenShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: GridView.builder(
        padding: const EdgeInsets.all(1),
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 1,
          mainAxisSpacing: 1,
        ),
        itemCount: 18, // Number of boxes to show during loading
        itemBuilder: (context, index) {
          return Container(color: Colors.white);
        },
      ),
    );
  }
}