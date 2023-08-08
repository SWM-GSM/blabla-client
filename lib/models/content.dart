import 'dart:convert';

Content contentFromJson(String str) => Content.fromJson(json.decode(str));

class Content {
  int id;
  int level;
  String topic;
  String title;
  String thumbnailUrl;
  bool isCompleted;

  Content({
    required this.id,
    required this.level,
    required this.topic,
    required this.title,
    required this.thumbnailUrl,
    required this.isCompleted,
  });

  factory Content.fromJson(Map<String, dynamic> json) => Content(
        id: json["id"],
        level: json["level"],
        topic: json["topic"],
        title: json["title"],
        thumbnailUrl: json["thumbnailUrl"],
        isCompleted: json["isCompleted"],
      );
}
