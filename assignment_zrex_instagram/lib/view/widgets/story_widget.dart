import 'package:assignment_zrex_instagram/model/story.dart';
import 'package:assignment_zrex_instagram/view/widgets/story_item.dart';
import 'package:flutter/material.dart';

class StoryWidget extends StatefulWidget {
  const StoryWidget({super.key});

  @override
  State<StoryWidget> createState() => _StoryWidgetState();
}

class _StoryWidgetState extends State<StoryWidget> {
  late Future<List<StoryModel>> _storiesFuture;

  @override
  void initState() {
    super.initState();
    // Initialize the future here to prevent re-firing on every build
    _storiesFuture = fetchStories();
  }

  // Simulate an API call
  Future<List<StoryModel>> fetchStories() async {
    await Future.delayed(const Duration(seconds: 2)); // Simulate network lag
    return [
      StoryModel(name: "Your story", imageUrl: "https://i.pravatar.cc/150?u=1", isUser: true),
      StoryModel(name: "john deo", imageUrl: "https://i.pravatar.cc/150?u=2", isLive: true),
      StoryModel(name: "Sparrow", imageUrl: "https://i.pravatar.cc/150?u=3"),
      StoryModel(name: "nick", imageUrl: "https://i.pravatar.cc/150?u=4"),
      StoryModel(name: "strange", imageUrl: "https://i.pravatar.cc/150?u=5"),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      
      child: FutureBuilder<List<StoryModel>>(
        future: _storiesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Show a loading indicator or Shimmer here
            return const Center(
              child: CircularProgressIndicator(color: Colors.pink, strokeWidth: 2),
            );
          } else if (snapshot.hasError) {
            return Center(child: Text("Error loading stories", style: TextStyle(color: Colors.black)));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No stories available"));
          }
    
          final stories = snapshot.data!;
    
          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: stories.length,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            itemBuilder: (context, index) {
              final story = stories[index];
              return StoryItem(
                name: story.name,
                isLive: story.isLive,
                isUser: story.isUser,
                imageUrl: story.imageUrl,
                
              );
            },
          );
        },
      ),
    );
  }
}