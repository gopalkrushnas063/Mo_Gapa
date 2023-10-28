class Story {
  final String title;
  final String type;
  final String content;
  final String image;
  final String icon;

  Story({
    required this.title,
    required this.type,
    required this.content,
    required this.image,
    required this.icon,
  });

  factory Story.fromJson(Map<String, dynamic> json) {
    return Story(
      title: json['title'] ?? 'No title',
      type: json['type'] ?? 'No type',
      content: json['content'] ?? 'No content',
      image: json['image'] ?? 'No image URL',
      icon: json['icon'] ?? 'No icon URL',
    );
  }
}
