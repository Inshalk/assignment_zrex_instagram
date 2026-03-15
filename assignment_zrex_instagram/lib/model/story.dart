class StoryModel {
  final String name;
  final String imageUrl;
  final bool isLive;
  final bool isUser;

  StoryModel({
    required this.name,
    required this.imageUrl,
    this.isLive = false,
    this.isUser = false,
  });
}