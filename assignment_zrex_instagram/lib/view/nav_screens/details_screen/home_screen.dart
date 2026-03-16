import 'package:assignment_zrex_instagram/view/screens/post.dart';
import 'package:assignment_zrex_instagram/view/screens/post_infinite.dart';
import 'package:assignment_zrex_instagram/view/widgets/header_widget_home.dart';
import 'package:assignment_zrex_instagram/view/widgets/story_widget.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _homeScrollController = ScrollController();

  @override
  void dispose() {
    _homeScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HeaderWidgetHome(),
      body: SingleChildScrollView(
        controller: _homeScrollController,
        child: Column(
          children: [
            StoryWidget(),            
            Post(),
          PostInfinite(mainScrollController: _homeScrollController),
          ],
        ),
      ),
    );
  }
}
