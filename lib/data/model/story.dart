class StoryModel {
  final int id;
  final String title;
  final String type;
  final String content;
  final String image;
  final String icon;

  StoryModel({
    required this.id,
    required this.title,
    required this.type,
    required this.content,
    required this.image,
    required this.icon,
  });

  factory StoryModel.fromJson(Map<String, dynamic> json) {
    return StoryModel(
      id: json['id'],
      title: json['title'],
      type: json['type'],
      content: json['content'],
      image: json['image'],
      icon: json['icon'],
    );
  }
}
