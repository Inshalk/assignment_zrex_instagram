import 'package:assignment_zrex_instagram/model/post_model.dart';
import 'package:assignment_zrex_instagram/view/widgets/post_card.dart';
import 'package:flutter/material.dart';

class Post extends StatefulWidget {
  const Post({super.key});

  @override
  State<Post> createState() => _PostState();
}

class _PostState extends State<Post> {
  final List<PostModel> posts = [
    PostModel(
      username: 'nayeemx01',
      profileImage: 'https://picsum.photos/id/10/200/200',
      images: ['https://picsum.photos/id/1/800/800', 'https://picsum.photos/id/2/800/800'],
    ),
    PostModel(
      username: 'rvcjinsta',
      profileImage: 'https://picsum.photos/id/20/200/200',
      images: ['https://picsum.photos/id/3/800/800'],
    ),
    PostModel(
      username: 'farzan_ashal',
      profileImage: 'https://picsum.photos/id/30/200/200',
      images: ['https://picsum.photos/id/4/800/800', 'https://picsum.photos/id/5/800/800'],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: posts.length, 
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(), 
      itemBuilder: (context, index) {
        final post = posts[index];

        return PostCard(
          username: post.username,
          profileImage: post.profileImage,
          images: post.images,
        );
      },
    );
  }
}