import 'package:assignment_zrex_instagram/model/post_model.dart';
import 'package:assignment_zrex_instagram/view/widgets/post_card.dart';
import 'package:assignment_zrex_instagram/utils/post_shimmer.dart';
import 'package:flutter/material.dart';

class Post extends StatefulWidget {
  const Post({super.key});

  @override
  State<Post> createState() => _PostState();
}

class _PostState extends State<Post> {
  // 1. Declare the Future
  late Future<List<PostModel>> _postsFuture;

  @override
  void initState() {
    super.initState();
    // 2. Initialize the future
    _postsFuture = fetchPosts();
  }

  // 3. Simulate an API fetch
  Future<List<PostModel>> fetchPosts() async {
    await Future.delayed(const Duration(seconds: 5)); // Simulate network delay
    return [
    PostModel(
      username: 'chronicle_scribe',
      profileImage: 'https://images.pexels.com/photos/2379004/pexels-photo-2379004.jpeg?auto=compress&cs=tinysrgb&w=200',
      images: [
        'https://images.pexels.com/photos/3532545/pexels-photo-3532545.jpeg?auto=compress&cs=tinysrgb&w=800', // Moody Street
        'https://images.pexels.com/photos/1640777/pexels-photo-1640777.jpeg?auto=compress&cs=tinysrgb&w=800', 
      ],
    ),
    PostModel(
      username: 'ghibli_dreamer',
      profileImage: 'https://images.pexels.com/photos/1239291/pexels-photo-1239291.jpeg?auto=compress&cs=tinysrgb&w=200',
      images: [
        'https://images.pexels.com/photos/210186/pexels-photo-210186.jpeg?auto=compress&cs=tinysrgb&w=800', 
      ],
    ),
    PostModel(
      username: 'neon_samurai',
      profileImage: 'https://images.pexels.com/photos/91227/pexels-photo-91227.jpeg?auto=compress&cs=tinysrgb&w=200',
      images: [
        'https://images.pexels.com/photos/1462630/pexels-photo-1462630.jpeg?auto=compress&cs=tinysrgb&w=800', 
        'https://images.pexels.com/photos/2174656/pexels-photo-2174656.jpeg?auto=compress&cs=tinysrgb&w=800', 
      ],
    ),
    PostModel(
      username: 'academy_of_spells',
      profileImage: 'https://images.pexels.com/photos/1181686/pexels-photo-1181686.jpeg?auto=compress&cs=tinysrgb&w=200',
      images: [
        'https://images.pexels.com/photos/1563356/pexels-photo-1563356.jpeg?auto=compress&cs=tinysrgb&w=800', 
      ],
    ),
  ];
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<PostModel>>(
      future: _postsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return ListView.builder(
            itemCount: 3,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) => const PostShimmer(),
          );
        }

        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No posts yet'));
        }

        final postsData = snapshot.data!;
        return ListView.builder(
          itemCount: postsData.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            final post = postsData[index];
            // Ensure your PostCard constructor matches these arguments
            return PostCard(
              username: post.username,
              profileImage: post.profileImage,
              images: post.images,
            );
          },
        );
      },
    );
  }
}

