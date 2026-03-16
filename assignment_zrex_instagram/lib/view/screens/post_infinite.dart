import 'package:assignment_zrex_instagram/model/post_model.dart';
import 'package:assignment_zrex_instagram/view/widgets/post_card.dart';
import 'package:assignment_zrex_instagram/utils/post_shimmer.dart';
import 'package:flutter/material.dart';

class PostInfinite extends StatefulWidget {
  // We accept the controller from the parent HomeScreen
  final ScrollController mainScrollController;
  const PostInfinite({super.key, required this.mainScrollController});

  @override
  State<PostInfinite> createState() => _PostState();
}

class _PostState extends State<PostInfinite> {
  final List<PostModel> _posts = [];
  int _nextPageKey = 0;
  bool _isLastPage = false;
  bool _isLoading = false;
  bool _isFirstLoad = true;

  @override
  void initState() {
    super.initState();
    _fetchPage(_nextPageKey);
    
    // Attach the listener to the parent's controller
    widget.mainScrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    // Check if parent reached bottom
    if (widget.mainScrollController.position.pixels >= 
        widget.mainScrollController.position.maxScrollExtent - 300) {
      if (!_isLastPage && !_isLoading) {
        _fetchPage(_nextPageKey);
      }
    }
  }

  Future<void> _fetchPage(int pageKey) async {
    if (_isLoading || _isLastPage) return;

    setState(() => _isLoading = true);

    await Future.delayed(const Duration(seconds: 2));
    final newItems = _getMockData(pageKey, 4);

    if (mounted) {
      setState(() {
        _isFirstLoad = false;
        _isLoading = false;
        if (newItems.isEmpty) {
          _isLastPage = true;
        } else {
          _nextPageKey = pageKey + newItems.length;
          _posts.addAll(newItems);
        }
      });
    }
  }

  List<PostModel> _getMockData(int start, int count) {
    if (start >= 30) return []; 
    return List.generate(count, (index) {
      int id = start + index;
      return PostModel(
        username: 'chronicle_scribe_$id',
        profileImage: 'https://picsum.photos/id/${id + 20}/200/200',
        images: ['https://picsum.photos/id/${id + 100}/800/800'],
      );
    });
  }

  @override
  void dispose() {
    // Important: Remove listener to prevent memory leaks
    widget.mainScrollController.removeListener(_scrollListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_isFirstLoad) {
      return ListView.builder(
        itemCount: 3,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) => const PostShimmer(),
      );
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(), 
      itemCount: _posts.length + (_isLastPage ? 0 : 1),
      itemBuilder: (context, index) {
        if (index < _posts.length) {
          final post = _posts[index];
          return PostCard(
            username: post.username,
            profileImage: post.profileImage,
            images: post.images,
          );
        } else {
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 32),
            child: Center(child: CircularProgressIndicator(color: Colors.blue)),
          );
        }
      },
    );
  }
}