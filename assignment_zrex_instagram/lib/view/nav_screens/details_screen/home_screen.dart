import 'package:assignment_zrex_instagram/view/screens/post.dart';
import 'package:assignment_zrex_instagram/view/widgets/header_widget_home.dart';
import 'package:assignment_zrex_instagram/view/widgets/post_card.dart';
import 'package:assignment_zrex_instagram/view/widgets/story_widget.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HeaderWidgetHome(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            StoryWidget(),
           Post()
          ],
        ),
      ),
    );
  }
}
