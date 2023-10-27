class Story {
  final String title;
  final String type;
  final String content;
  final String image;

  Story({required this.title, required this.type, required this.content, required this.image});

  factory Story.fromJson(Map<String, dynamic> json) {
    return Story(
      title: json['title'],
      type: json['type'],
      content: json['content'],
      image: json['image'],
    );
  }
}
